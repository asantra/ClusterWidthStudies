/*
  Copyright (C) 2002-2017 CERN for the benefit of the ATLAS collaboration
*/

/**    @file SCTLorentzMonTool.cxx
 *
 *    @author Elias Coniavitis based on code from Luca Fiorini,
 *    Shaun Roe, Manuel Diaz, Rob McPherson & Richard Batley
 *    Modified by Yuta
 */
#include "SCT_Monitoring/SCTLorentzMonTool.h"
#include "deletePointers.h"
#include "SCT_NameFormatter.h"
#include <cmath>
#include <type_traits>

#include "GaudiKernel/StatusCode.h"
#include "GaudiKernel/IToolSvc.h"

#include "TH1F.h"
#include "TH2F.h"
#include "TProfile2D.h"
#include "TF1.h"
#include "DataModel/DataVector.h"
#include "Identifier/Identifier.h"
#include "InDetIdentifier/SCT_ID.h"
#include "InDetReadoutGeometry/SCT_DetectorManager.h"
#include "TrkTrack/TrackCollection.h"
#include "InDetRIO_OnTrack/SiClusterOnTrack.h"
#include "InDetPrepRawData/SiCluster.h"
#include "TrkParameters/TrackParameters.h"

#include "TrkTrack/Track.h"
#include "TrkTrack/TrackCollection.h"
#include "TrkToolInterfaces/IResidualPullCalculator.h"
#include "TrkToolInterfaces/IRIO_OnTrackCreator.h"

// for sct residuals
#include "TrkTrackSummary/TrackSummary.h"
#include "EventInfo/EventID.h"
#include "EventInfo/EventInfo.h"

using namespace std;
using namespace Rec;
using namespace SCT_Monitoring;

namespace{//anonymous namespace for functions at file scope
  template< typename T > Identifier surfaceOnTrackIdentifier(T & tsos, const bool useTrackParameters=true){
    Identifier result(0); //default constructor produces invalid value
    const Trk::MeasurementBase* mesb = tsos->measurementOnTrack();
    if (mesb and mesb->associatedSurface().associatedDetectorElement())
      result = mesb->associatedSurface().associatedDetectorElement()->identify();
    else if (useTrackParameters and tsos->trackParameters()){
      //       result = tsos->trackParameters()->associatedSurface()->associatedDetectorElementIdentifier();
      result = tsos->trackParameters()->associatedSurface().associatedDetectorElementIdentifier();
    }
    return result;
  }
}//namespace end
// ====================================================================================================
/** Constructor, calls base class constructor with parameters
 *
 *  several properties are "declared" here, allowing selection
 *  of the filepath for histograms etc
 */
// ====================================================================================================
SCTLorentzMonTool::SCTLorentzMonTool(const string &type, const string &name,
                                     const IInterface *parent) : SCTMotherTrigMonTool(type, name, parent),
  m_trackToVertexTool("Reco::TrackToVertex", this), // for TrackToVertexTool
  m_phiVsNstrips{},
  m_phiVsNstrips_075{},
  m_phiVsNstrips_15{},
  m_phiVsNstrips_more15{},
  m_phiVsNstrips_100{},
  m_phiVsNstrips_111{},
  m_phiVsNstrips_Side{},
  m_phiVsNstrips_Side_100{},
  m_phiVsNstrips_Side_111{},
  m_holeSearchTool("InDet::InDetTrackHoleSearchTool"),
  m_pSCTHelper(nullptr),
  m_sctmgr(nullptr) {
  /** sroe 3 Sept 2015:
     histoPathBase is declared as a property in the base class, assigned to m_path
     with default as empty string.
     Declaring it here as well gives rise to compilation warning
     WARNING duplicated property name 'histoPathBase', see https://its.cern.ch/jira/browse/GAUDI-1023

     declareProperty("histoPathBase", m_stream = "/stat"); **/
  m_stream = "/stat";
  declareProperty("tracksName", m_tracksName = "CombinedInDetTracks"); // this recommended
  declareProperty("TrackToVertexTool", m_trackToVertexTool); // for TrackToVertexTool
  m_numberOfEvents = 0;
  declareProperty("HoleSearch", m_holeSearchTool);
}
// ====================================================================================================
// ====================================================================================================
SCTLorentzMonTool::~SCTLorentzMonTool() {
  // nada
}

// ====================================================================================================
//                       SCTLorentzMonTool :: bookHistograms
// ====================================================================================================
// StatusCode SCTLorentzMonTool::bookHistograms( bool /*isNewEventsBlock*/, bool isNewLumiBlock, bool isNewRun
// )//suppress 'unused' compiler warning     // hidetoshi 14.01.21
StatusCode
SCTLorentzMonTool::bookHistogramsRecurrent( ) {                                                                                              //
                                                                                                                                             // hidetoshi
                                                                                                                                             // 14.01.21
  CHECK (m_holeSearchTool.retrieve());
  m_path = "";
  if (newRunFlag()) {
    m_numberOfEvents = 0;                                                                                                                        //
                                                                                                                                                 // hidetoshi
                                                                                                                                                 // 14.01.21
  }
  ATH_MSG_DEBUG("initialize being called");
  detStore()->retrieve(m_pSCTHelper, "SCT_ID");
  ATH_CHECK(detStore()->retrieve(m_sctmgr, "SCT"));
  ATH_MSG_DEBUG("SCT detector manager found: layout is \"" << m_sctmgr->getLayout() << "\"");
  /* Retrieve TrackToVertex extrapolator tool */
  ATH_CHECK(m_trackToVertexTool.retrieve());
  // Booking  Track related Histograms
  if (bookLorentzHistos().isFailure()) {
    msg(MSG::WARNING) << "Error in bookLorentzHistos()" << endmsg;                                // hidetoshi 14.01.22
  }
  return StatusCode::SUCCESS;
}

// ====================================================================================================
//                       SCTLorentzMonTool :: bookHistograms
// ====================================================================================================
StatusCode
SCTLorentzMonTool::bookHistograms( ) {                                                                                                      //
                                                                                                                                            // hidetoshi
                                                                                                                                            // 14.01.21
  CHECK (m_holeSearchTool.retrieve());
  m_path = "";
  m_numberOfEvents = 0;                                                                                                                                  //
                                                                                                                                                         // hidetoshi
                                                                                                                                                         // 14.01.21
  ATH_MSG_DEBUG("initialize being called");
  ATH_CHECK(detStore()->retrieve(m_pSCTHelper, "SCT_ID"));
  ATH_CHECK(detStore()->retrieve(m_sctmgr, "SCT"));
  ATH_MSG_DEBUG("SCT detector manager found: layout is \"" << m_sctmgr->getLayout() << "\"");
  /* Retrieve TrackToVertex extrapolator tool */
  ATH_CHECK(m_trackToVertexTool.retrieve());
  // Booking  Track related Histograms
  if (bookLorentzHistos().isFailure()) {
    msg(MSG::WARNING) << "Error in bookLorentzHistos()" << endmsg;                                // hidetoshi 14.01.22
  }
  return StatusCode::SUCCESS;
}

// ====================================================================================================
//                        SCTLorentzMonTool :: fillHistograms
/// This is the real workhorse, called for each event. It retrieves the data each time
// ====================================================================================================
StatusCode
SCTLorentzMonTool::fillHistograms() {
  // should use database for this!
  constexpr int layer100[] = {
    2, 2, 3, 2, 2, 2, 0, 2, 3, 2, 0, 2, 3, 2, 3, 2, 0, 2, 3, 0, 2, 0, 2, 3, 2, 2, 2, 0, 0, 0, 0, 0, 0, 3, 0, 3, 2, 0, 2,
    2, 0, 3, 3, 3, 0, 2, 2, 2, 2, 2, 2, 2, 3, 2, 2, 3, 3, 2, 2, 2, 2, 2, 3, 3, 2, 3, 2, 2, 2, 3, 3, 3, 2, 2, 2, 2, 3, 3,
    2, 3, 2, 3, 3, 2, 3, 2, 2, 2, 2, 2, 2, 2
  };
  constexpr int phi100[] = {
    29, 29, 6, 13, 23, 13, 14, 29, 9, 29, 14, 29, 9, 29, 39, 32, 21, 32, 13, 22, 32, 22, 32, 13, 32, 32, 32, 20, 20, 20,
    20, 20, 20, 13, 21, 17, 33, 5, 33, 33, 31, 6, 19, 47, 21, 37, 37, 37, 37, 33, 37, 37, 24, 33, 33, 47, 19, 33, 33,
    37, 37, 37, 55, 9, 38, 24, 37, 38, 8, 9, 9, 26, 38, 38, 38, 38, 39, 39, 38, 11, 45, 54, 54, 24, 31, 14, 47, 45, 47,
    47, 47, 47
  };
  constexpr int eta100[] = {
    3, -4, -6, 2, 6, 3, -5, -1, 6, -2, -6, -5, 5, -3, 2, 6, -3, 5, 5, 3, 4, 2, 2, 2, -1, -3, -4, 1, -1, -2, -3, -4, 4,
    -1, -5, 6, 2, 4, 3, 1, 6, -2, 6, 3, -6, -1, 2, 1, 3, -5, 4, 5, -3, -4, -3, -5, -2, -1, -2, -3, -2, -4, -3, 2, 3, -6,
    -5, 4, 6, 1, -6, 1, 1, -5, -4, -3, -3, -5, -2, 1, 5, 5, 4, 4, 5, 4, -1, -5, 3, 4, 1, -5
  };
  constexpr unsigned int layer100_n = sizeof(layer100) / sizeof(*layer100);
  constexpr unsigned int phi100_n = sizeof(phi100) / sizeof(*phi100);
  constexpr unsigned int eta100_n = sizeof(eta100) / sizeof(*eta100);
  constexpr bool theseArraysAreEqualInLength = ((layer100_n == phi100_n)and(phi100_n == eta100_n));

  static_assert(theseArraysAreEqualInLength, "Coordinate arrays for <100> wafers are not of equal length");

  ATH_MSG_DEBUG("enters fillHistograms");

  const TrackCollection *tracks(0);
  if (evtStore()->contains<TrackCollection> (m_tracksName)) {
    if (evtStore()->retrieve(tracks, m_tracksName).isFailure()) {
      msg(MSG::WARNING) << " TrackCollection not found: Exit SCTLorentzTool" << m_tracksName << endmsg;
      return StatusCode::SUCCESS;
    }
  } else {
    msg(MSG::WARNING) << "Container " << m_tracksName << " not found.  Exit SCTLorentzMonTool" << endmsg;
    return StatusCode::SUCCESS;
  }

  TrackCollection::const_iterator trkitr = tracks->begin();
  TrackCollection::const_iterator trkend = tracks->end();
  // taking the event EventInfo 
  const EventInfo *pEvent(0);
  (evtStore()->retrieve(pEvent)).ignore();
  if (not pEvent) {
      ATH_MSG_ERROR("no pointer to track2!!!");
  }
  EventID *eventID = pEvent->event_ID();

  for (; trkitr != trkend; ++trkitr) {
    // Get track
    const Trk::Track *track = m_holeSearchTool->getTrackWithHoles(**trkitr);
    if (not track) {
      ATH_MSG_WARNING ("track pointer is invalid");
      continue;
    }

    const Trk::Track * track2 = (*trkitr);
    if (not track2) {
      ATH_MSG_ERROR("no pointer to track2!!!");
      continue;
    }

    // Get pointer to track state on surfaces
    const DataVector<const Trk::TrackStateOnSurface> *trackStates = track->trackStateOnSurfaces();
    if (not trackStates) {
      msg(MSG::WARNING) << "for current track, TrackStateOnSurfaces == Null, no data will be written for this track" <<
      endmsg;
      continue;
    }

    const Trk::TrackSummary *summary = track2->trackSummary();
    if (not summary) {
      msg(MSG::WARNING) << " null trackSummary" << endmsg;
      continue;
    }

    DataVector<const Trk::TrackStateOnSurface>::const_iterator endit = trackStates->end();
    for (DataVector<const Trk::TrackStateOnSurface>::const_iterator it = trackStates->begin(); it != endit; ++it) {
      if ((*it)->type(Trk::TrackStateOnSurface::Measurement)) {
        const InDet::SiClusterOnTrack *clus =
          dynamic_cast<const InDet::SiClusterOnTrack *>((*it)->measurementOnTrack());
        if (clus) { // Is it a SiCluster? If yes...
          const InDet::SiCluster *RawDataClus = dynamic_cast<const InDet::SiCluster *>(clus->prepRawData());
          if (not RawDataClus) {
            continue; // Continue if dynamic_cast returns null
          }
          if (RawDataClus->detectorElement()->isSCT()) {
            const Identifier sct_id = clus->identify();
            const int bec(m_pSCTHelper->barrel_ec(sct_id));
            const int layer(m_pSCTHelper->layer_disk(sct_id));
            const int side(m_pSCTHelper->side(sct_id));
            const int eta(m_pSCTHelper->eta_module(sct_id));
            const int phi(m_pSCTHelper->phi_module(sct_id));

            bool in100 = false;
            // wtf is this?
            for (unsigned int i = 0; i < layer100_n; i++) {
              if (layer100[i] == layer && eta100[i] == eta && phi100[i] == phi) {
                in100 = true;
                break;
              }
            }
            
            // find cluster size
            const std::vector<Identifier> &rdoList = RawDataClus->rdoList();
            int nStrip = rdoList.size();
            const Trk::TrackParameters *trkp = dynamic_cast<const Trk::TrackParameters *>((*it)->trackParameters());
            if (not trkp) {
              msg(MSG::WARNING) << " Null pointer to MeasuredTrackParameters" << endmsg;
              continue;
            }

            const Trk::Perigee *perigee = track->perigeeParameters();

            if (perigee) {
              // Get angle to wafer surface
              float phiToWafer(90.), thetaToWafer(90.);
              float sinAlpha = 0.; // for barrel, which is the only thing considered here
              float pTrack[3];
              pTrack[0] = trkp->momentum().x();
              pTrack[1] = trkp->momentum().y();
              pTrack[2] = trkp->momentum().z();
              int iflag = findAnglesToWaferSurface(pTrack, sinAlpha, clus->identify(), thetaToWafer, phiToWafer);
              if (iflag < 0) {
                msg(MSG::WARNING) << "Error in finding track angles to wafer surface" << endmsg;
                continue; // Let's think about this (later)... continue, break or return?
              }

              bool passesCuts = true;

              if ((AthenaMonManager::dataType() == AthenaMonManager::cosmics) &&
                  (trkp->momentum().mag() > 500.) &&  // Pt > 500MeV
                  (summary->get(Trk::numberOfSCTHits) > 7)// && // #SCTHits >6, /// changed to 7 from 6 by Arka on August 9, 2017
                  ) {
                passesCuts = true;
              }// 01.02.2015
              else if( (track->perigeeParameters()->parameters()[Trk::qOverP] < 0.) &&  // use negative track only for 2015 selection, now with Taka's request this is removed on Jan 29, 2018
                     (fabs( perigee->parameters()[Trk::d0] ) < 1.) &&  // d0 < 1mm
                       //(fabs( perigee->parameters()[Trk::z0] * sin(perigee->parameters()[Trk::theta]) ) < 1.) && // d0 < 1mm 
                       (trkp->momentum().perp() > 500.) &&   // Pt > 500MeV 
                        (summary->get(Trk::numberOfSCTHits) > 7 ) && // #SCTHits >6, /// changed to 7 from 6 by Arka on August 9, 2017
                        (summary->get(Trk::numberOfPixelHits) > 1) // number of pixel hits > 1, added by Arka on August 9, 2017
                       ){
                passesCuts=true;
              }else {
                passesCuts = false;
              }

              if (passesCuts) {
                /// fill for endcaps
                if(bec==-2 || bec==2){
                   h_NstripsEC[layer]->Fill(nStrip);
                   if(eta==0)h_ModuleOuter->Fill(phi);
                   if(eta==1)h_ModuleMiddle->Fill(phi);
                   if(eta==2)h_ModuleInner->Fill(phi);
                   if(layer >= 0 && layer <= 8 && phi >= 0 && phi <= 51 && eta == 0){
                       h_NstripsECOuter->Fill(nStrip);
                   }
                   if(layer >= 0 && layer <= 7 && phi >= 0 && phi <= 39 && eta == 1){
                       h_NstripsECMiddle->Fill(nStrip);
                   }
                   if(layer >= 1 && layer <= 5 && phi >= 0 && phi <= 39 && eta == 2){
                       h_NstripsECInner->Fill(nStrip);
                   }
                   
                   if(bec==-2){
                       h_NstripsECSideC[layer]->Fill(nStrip);
                       if(layer >= 0 && layer <= 8 && phi >= 0 && phi <= 51 && eta == 0)h_NstripsECSideCOuter->Fill(nStrip);
                       if(layer >= 0 && layer <= 7 && phi >= 0 && phi <= 39 && eta == 1)h_NstripsECSideCMiddle->Fill(nStrip);
                       if(layer >= 1 && layer <= 5 && phi >= 0 && phi <= 39 && eta == 2)h_NstripsECSideCInner->Fill(nStrip);
                   }
                   if(bec==2){
                       h_NstripsECSideA[layer]->Fill(nStrip);
                       if(layer >= 0 && layer <= 8 && phi >= 0 && phi <= 51 && eta == 0)h_NstripsECSideAOuter->Fill(nStrip);
                       if(layer >= 0 && layer <= 7 && phi >= 0 && phi <= 39 && eta == 1)h_NstripsECSideAMiddle->Fill(nStrip);
                       if(layer >= 1 && layer <= 5 && phi >= 0 && phi <= 39 && eta == 2)h_NstripsECSideAInner->Fill(nStrip);
                   }
                }
                  
                  
                // Fill profile for barrel
                if(bec != 0)continue;
                //if(layer!=0)continue;
                h_Nstrips[layer]->Fill(nStrip);
                if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_phiMinus5Degree[layer]->Fill(nStrip);
                m_phiVsNstrips[layer]->Fill(phiToWafer, nStrip, 1.);
                if(fabs(trkp->eta()) <= 0.75){
                    m_phiVsNstrips_075[layer]->Fill(phiToWafer, nStrip, 1.);
                    h_Nstrips_075[layer]->Fill(nStrip);
                    if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_075_phiMinus5Degree[layer]->Fill(nStrip);
                }
                if(fabs(trkp->eta()) > 0.75 && fabs(trkp->eta()) <= 1.5){
                    m_phiVsNstrips_15[layer]->Fill(phiToWafer, nStrip, 1.);
                    h_Nstrips_15[layer]->Fill(nStrip);
                    if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_15_phiMinus5Degree[layer]->Fill(nStrip);
                }
                if(fabs(trkp->eta()) > 1.5){
                    m_phiVsNstrips_more15[layer]->Fill(phiToWafer, nStrip, 1.);
                    h_Nstrips_more15[layer]->Fill(nStrip);
                    if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_more15_phiMinus5Degree[layer]->Fill(nStrip);
                }
                
                uint64_t event_number = eventID->event_number();
                const Trk::Perigee* startPerigee = track2->perigeeParameters();
                //float phi0 = 
                float trackPhi = startPerigee->parameters()[Trk::phi0];
                
                //std::cout << "Arka Hits " << event_number << " " << trkp->momentum().perp() << " " << trkp->eta() << " " << trackPhi << " " << phiToWafer << " " << nStrip << " " << bec << " " << layer << " " << eta << " " << phi << " " << side << " " << trkp->charge() << std::endl;
                
                m_phiVsNstrips_Side[layer][side]->Fill(phiToWafer, nStrip, 1.);
                h_Nstrips_Side[layer][side]->Fill(nStrip);
                if (in100) {
                  // cout << "This event is going to 100" << endl;
                  m_phiVsNstrips_100[layer]->Fill(phiToWafer, nStrip, 1.);
                  m_phiVsNstrips_Side_100[layer][side]->Fill(phiToWafer, nStrip, 1.);
                  h_Nstrips_100[layer]->Fill(nStrip);
                  h_Nstrips_Side_100[layer][side]->Fill(nStrip);
                }else {
                  m_phiVsNstrips_111[layer]->Fill(phiToWafer, nStrip, 1.);
                  m_phiVsNstrips_Side_111[layer][side]->Fill(phiToWafer, nStrip, 1.);
                  
                  h_Nstrips_111[layer]->Fill(nStrip);
                  h_Nstrips_Side_111[layer][side]->Fill(nStrip);
                }
              }// end if passesCuts
            }// end if mtrkp
          } // end if SCT..
        } // end if(clus)
      } // if((*it)->type(Trk::TrackStateOnSurface::Measurement)){
      else if((*it)->type(Trk::TrackStateOnSurface::Hole)) {
        Identifier surfaceID;
        surfaceID = surfaceOnTrackIdentifier(*it);
        if(not m_pSCTHelper->is_sct(surfaceID)) continue; //We only care about SCT
        const int bec(m_pSCTHelper->barrel_ec(surfaceID));
        const int layer(m_pSCTHelper->layer_disk(surfaceID));
        const int side(m_pSCTHelper->side(surfaceID));
        const int eta(m_pSCTHelper->eta_module(surfaceID));
        const int phi(m_pSCTHelper->phi_module(surfaceID));
        bool in100 = false;
            
        //wtf is this?
        for (unsigned int i=0 ; i<layer100_n ; i++){
            if (layer100[i]==layer && eta100[i]==eta && phi100[i]==phi){
                in100=true;
                break;
            }
        }
        // find cluster size
        int nStrip = 0;
        const Trk::TrackParameters *trkp = dynamic_cast<const Trk::TrackParameters*>( (*it)->trackParameters() );
        if (not trkp) {
            ATH_MSG_WARNING(" Null pointer to MeasuredTrackParameters");
            continue;
        }

        const Trk::Perigee* perigee = track->perigeeParameters();

        if (perigee){
            //Get angle to wafer surface
            float phiToWafer(90.),thetaToWafer(90.);
            float sinAlpha = 0.; //for barrel, which is the only thing considered here
            float pTrack[3];
            pTrack[0] = trkp->momentum().x();
            pTrack[1] = trkp->momentum().y();
            pTrack[2] = trkp->momentum().z();
            int iflag = findAnglesToWaferSurface (pTrack, sinAlpha, surfaceID, thetaToWafer, phiToWafer );
            if ( iflag < 0) {
                ATH_MSG_WARNING("Error in finding track angles to wafer surface");
                continue; // Let's think about this (later)... continue, break or return?
            }
            bool passesCuts = true;
            if( (AthenaMonManager::dataType() ==  AthenaMonManager::cosmics) &&
                (trkp->momentum().mag() > 500.) &&  // Pt > 500MeV
                (summary->get(Trk::numberOfSCTHits) > 7 )// && // #SCTHits >6, /// changed to 7 from 6 by Arka on August 9, 2017
                ){
                passesCuts=true;
            }
            else if( (track->perigeeParameters()->parameters()[Trk::qOverP] < 0.) && // use negative track only for 2015 selection, now with Taka's request this is removed on Jan 29, 2018
                            (fabs( perigee->parameters()[Trk::d0] ) < 1.) &&  // d0 < 1mm
                            //(fabs( perigee->parameters()[Trk::z0] * sin(perigee->parameters()[Trk::theta]) ) < 1.) && // d0 < 1mm 
                                (trkp->momentum().perp() > 500.) &&   // Pt > 500MeV 
                                (summary->get(Trk::numberOfSCTHits) > 7 ) && // #SCTHits >6, /// changed to 7 from 6 by Arka on August 9, 2017
                                (summary->get(Trk::numberOfPixelHits) > 1) // number of pixel hits > 1, added by Arka on August 9, 2017
                            ){
                passesCuts=true;
            }else{
                passesCuts=false;
            }

            if (passesCuts) {
                // Fill profile for endcap
                if(bec==-2 || bec==2){
                   h_NstripsEC[layer]->Fill(nStrip);
                   
                   if(eta==0)h_ModuleOuter->Fill(phi);
                   if(eta==1)h_ModuleMiddle->Fill(phi);
                   if(eta==2)h_ModuleInner->Fill(phi);
                   if(layer >= 0 && layer <= 8 && phi >= 0 && phi <= 51 && eta == 0){
                       h_NstripsECOuter->Fill(nStrip);
                   }
                   if(layer >= 0 && layer <= 7 && phi >= 0 && phi <= 39 && eta == 1){
                       h_NstripsECMiddle->Fill(nStrip);
                   }
                   if(layer >= 1 && layer <= 5 && phi >= 0 && phi <= 39 && eta == 2){
                       h_NstripsECInner->Fill(nStrip);
                   }
                   if(bec==-2){
                       h_NstripsECSideC[layer]->Fill(nStrip);
                       if(layer >= 0 && layer <= 8 && phi >= 0 && phi <= 51 && eta == 0)h_NstripsECSideCOuter->Fill(nStrip);
                       if(layer >= 0 && layer <= 7 && phi >= 0 && phi <= 39 && eta == 1)h_NstripsECSideCMiddle->Fill(nStrip);
                       if(layer >= 1 && layer <= 5 && phi >= 0 && phi <= 39 && eta == 2)h_NstripsECSideCInner->Fill(nStrip);
                   }
                   if(bec==2){
                       h_NstripsECSideA[layer]->Fill(nStrip);
                       if(layer >= 0 && layer <= 8 && phi >= 0 && phi <= 51 && eta == 0)h_NstripsECSideAOuter->Fill(nStrip);
                       if(layer >= 0 && layer <= 7 && phi >= 0 && phi <= 39 && eta == 1)h_NstripsECSideAMiddle->Fill(nStrip);
                       if(layer >= 1 && layer <= 5 && phi >= 0 && phi <= 39 && eta == 2)h_NstripsECSideAInner->Fill(nStrip);
                   }
                }
                
                // Fill profile for barrel
                if(bec != 0)continue;
                //if(layer!=0)continue;
                h_Nstrips[layer]->Fill(nStrip);
                if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_phiMinus5Degree[layer]->Fill(nStrip);
                m_phiVsNstrips[layer]->Fill(phiToWafer, nStrip, 1.);
                if(fabs(trkp->eta()) <= 0.75){
                    m_phiVsNstrips_075[layer]->Fill(phiToWafer, nStrip, 1.);
                    h_Nstrips_075[layer]->Fill(nStrip);
                    if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_075_phiMinus5Degree[layer]->Fill(nStrip);
                }
                if(fabs(trkp->eta()) > 0.75 && fabs(trkp->eta()) <= 1.5){
                    m_phiVsNstrips_15[layer]->Fill(phiToWafer, nStrip, 1.);
                    h_Nstrips_15[layer]->Fill(nStrip);
                    if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_15_phiMinus5Degree[layer]->Fill(nStrip);
                }
                if(fabs(trkp->eta()) > 1.5){
                    m_phiVsNstrips_more15[layer]->Fill(phiToWafer, nStrip, 1.);
                    h_Nstrips_more15[layer]->Fill(nStrip);
                    if(phiToWafer >= -5.25 && phiToWafer <= -4.75)h_Nstrips_more15_phiMinus5Degree[layer]->Fill(nStrip);
                }
                uint64_t event_number = eventID->event_number();
                const Trk::Perigee* startPerigee = track2->perigeeParameters();
                float trackPhi = startPerigee->parameters()[Trk::phi0];
                
                m_phiVsNstrips_Side[layer][side]->Fill(phiToWafer, nStrip, 1.);
                h_Nstrips_Side[layer][side]->Fill(nStrip);
                if (in100) {
                    // cout << "This event is going to 100" << endl;
                    m_phiVsNstrips_100[layer]->Fill(phiToWafer, nStrip, 1.);
                    m_phiVsNstrips_Side_100[layer][side]->Fill(phiToWafer, nStrip, 1.);
                    
                    h_Nstrips_100[layer]->Fill(nStrip);
                    h_Nstrips_Side_100[layer][side]->Fill(nStrip);
                }else {
                    m_phiVsNstrips_111[layer]->Fill(phiToWafer, nStrip, 1.);
                    m_phiVsNstrips_Side_111[layer][side]->Fill(phiToWafer, nStrip, 1.);
                    
                    h_Nstrips_111[layer]->Fill(nStrip);
                    h_Nstrips_Side_111[layer][side]->Fill(nStrip);
                }
            }// end if passesCuts
        }// end if mtrkp
      } // if((*it)->type(Trk::TrackStateOnSurface::Measurement)){
    }// end of loop on TrackStatesonSurface (they can be SiClusters, TRTHits,..)
    delete track;
    track=0;
  } // end of loop on tracks

  m_numberOfEvents++;
  return StatusCode::SUCCESS;
}

// ====================================================================================================
//                             SCTLorentzMonTool :: procHistograms
// ====================================================================================================
StatusCode
SCTLorentzMonTool::procHistograms() {                                                                                                                //
                                                                                                                                                     // hidetoshi
                                                                                                                                                     // 14.01.21
  if (endOfRunFlag()) {
    ATH_MSG_DEBUG("finalHists()");
    ATH_MSG_DEBUG("Total Rec Event Number: " << m_numberOfEvents);
    ATH_MSG_DEBUG("Calling checkHists(true); true := end of run");
    if (checkHists(true).isFailure()) {
      ATH_MSG_WARNING("Error in checkHists(true)");
    }
  }
  ATH_MSG_DEBUG("Exiting finalHists");
  return StatusCode::SUCCESS;
}

StatusCode
SCTLorentzMonTool::checkHists(bool /*fromFinalize*/) {
  return StatusCode::SUCCESS;
}

// ====================================================================================================
//                              SCTLorentzMonTool :: bookLorentzHistos
// ====================================================================================================
StatusCode
SCTLorentzMonTool::bookLorentzHistos() {                                                                                                                //
                                                                                                                                                        // hidetoshi
                                                                                                                                                        // 14.01.22
  const int nLayers(4), nECLayers(9);
  const int nSides(2);
  string stem = m_path + "/SCT/GENERAL/lorentz/";
  //    MonGroup Lorentz(this,m_path+"SCT/GENERAL/lorentz",expert,run);        // hidetoshi 14.01.21
  MonGroup Lorentz(this, m_path + "SCT/GENERAL/lorentz", run, ATTRIB_UNMANAGED);     // hidetoshi 14.01.21

  string hNum[nLayers] = {
    "0", "1", "2", "3"
  };
  string hNumEC[nECLayers] = {
    "0", "1", "2", "3", "4", "5", "6", "7", "8"
  };
  string hNumS[nSides] = {
    "0", "1"
  };
  int nProfileBins = 360;

  int success = 1;
  
  for (int l = 0; l != nLayers; ++l) {
    // granularity set to one profile/layer for now
    int iflag = 0;
    m_phiVsNstrips_100[l] = pFactory("h_phiVsNstrips_100" + hNum[l], "100 - Inc. Angle vs nStrips for Layer " + hNum[l],
                                     nProfileBins, -90., 90., Lorentz, iflag);
    m_phiVsNstrips_111[l] = pFactory("h_phiVsNstrips_111" + hNum[l], "111 - Inc. Angle vs nStrips for Layer " + hNum[l],
                                     nProfileBins, -90., 90., Lorentz, iflag);

    m_phiVsNstrips[l] = pFactory("h_phiVsNstrips" + hNum[l], "Inc. Angle vs nStrips for Layer" + hNum[l], nProfileBins,
                                 -90., 90., Lorentz, iflag);
    m_phiVsNstrips[l]->GetXaxis()->SetTitle("#phi to Wafer");
    m_phiVsNstrips[l]->GetYaxis()->SetTitle("Num of Strips");
    
    
    m_phiVsNstrips_075[l] = pFactory("h_phiVsNstrips_075_" + hNum[l], "Inc. Angle vs nStrips for Layer" + hNum[l], nProfileBins,
                                 -90., 90., Lorentz, iflag);
    m_phiVsNstrips_075[l]->GetXaxis()->SetTitle("#phi to Wafer");
    m_phiVsNstrips_075[l]->GetYaxis()->SetTitle("Num of Strips");
    
    
    m_phiVsNstrips_15[l] = pFactory("h_phiVsNstrips_15_" + hNum[l], "Inc. Angle vs nStrips for Layer" + hNum[l], nProfileBins,
                                 -90., 90., Lorentz, iflag);
    m_phiVsNstrips_15[l]->GetXaxis()->SetTitle("#phi to Wafer");
    m_phiVsNstrips_15[l]->GetYaxis()->SetTitle("Num of Strips");
    
    
    m_phiVsNstrips_more15[l] = pFactory("h_phiVsNstrips_more15_" + hNum[l], "Inc. Angle vs nStrips for Layer" + hNum[l], nProfileBins,
                                 -90., 90., Lorentz, iflag);
    m_phiVsNstrips_more15[l]->GetXaxis()->SetTitle("#phi to Wafer");
    m_phiVsNstrips_more15[l]->GetYaxis()->SetTitle("Num of Strips");
    

    m_phiVsNstrips_100[l]->GetXaxis()->SetTitle("#phi to Wafer");
    m_phiVsNstrips_100[l]->GetYaxis()->SetTitle("Num of Strips");

    m_phiVsNstrips_111[l]->GetXaxis()->SetTitle("#phi to Wafer");
    m_phiVsNstrips_111[l]->GetYaxis()->SetTitle("Num of Strips");
    
    
    /// 1 dimensional histograms
    
    h_Nstrips[l]  = h1MyFactory("h_Nstrips_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips[l]->GetYaxis()->SetTitle("events");
    
    h_Nstrips_075[l]  = h1MyFactory("h_Nstrips_075_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_075[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_075[l]->GetYaxis()->SetTitle("events");
    
    
    h_Nstrips_15[l]  = h1MyFactory("h_Nstrips_15_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_15[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_15[l]->GetYaxis()->SetTitle("events");
    
    h_Nstrips_more15[l]  = h1MyFactory("h_Nstrips_more15_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_more15[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_more15[l]->GetYaxis()->SetTitle("events");
    
    
    
    
    /// only for negative 5 degree slice.
    
    h_Nstrips_phiMinus5Degree[l]  = h1MyFactory("h_Nstrips_phiMinus5Degree_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_phiMinus5Degree[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_phiMinus5Degree[l]->GetYaxis()->SetTitle("events");
    
    h_Nstrips_075_phiMinus5Degree[l]  = h1MyFactory("h_Nstrips_075_phiMinus5Degree_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_075_phiMinus5Degree[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_075_phiMinus5Degree[l]->GetYaxis()->SetTitle("events");
    
    
    h_Nstrips_15_phiMinus5Degree[l]  = h1MyFactory("h_Nstrips_15_phiMinus5Degree_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_15_phiMinus5Degree[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_15_phiMinus5Degree[l]->GetYaxis()->SetTitle("events");
    
    h_Nstrips_more15_phiMinus5Degree[l]  = h1MyFactory("h_Nstrips_more15_phiMinus5Degree_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_more15_phiMinus5Degree[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_more15_phiMinus5Degree[l]->GetYaxis()->SetTitle("events");
    
    
    h_Nstrips_100[l]  = h1MyFactory("h_Nstrips_100_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_100[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_100[l]->GetYaxis()->SetTitle("events");
    
    
    h_Nstrips_111[l]  = h1MyFactory("h_Nstrips_111_"+hNum[l], "1D cluster width for layer "+hNum[l], 41, -0.5, 40.5, Lorentz, iflag);
    h_Nstrips_111[l]->GetXaxis()->SetTitle("Num of Strips");
    h_Nstrips_111[l]->GetYaxis()->SetTitle("events");
    

    for (int side = 0; side < nSides; ++side) {
      m_phiVsNstrips_Side_100[l][side] = pFactory("h_phiVsNstrips_100_" + hNum[l] + "Side" + hNumS[side],
                                                  "100 - Inc. Angle vs nStrips for Layer Side " + hNum[l] + hNumS[side],
                                                  nProfileBins, -90., 90., Lorentz, iflag);
      m_phiVsNstrips_Side_111[l][side] = pFactory("h_phiVsNstrips_111_" + hNum[l] + "Side" + hNumS[side],
                                                  "111 - Inc. Angle vs nStrips for Layer Side " + hNum[l] + hNumS[side],
                                                  nProfileBins, -90., 90., Lorentz, iflag);
      m_phiVsNstrips_Side[l][side] = pFactory("h_phiVsNstrips" + hNum[l] + "Side" + hNumS[side],
                                              "Inc. Angle vs nStrips for Layer Side" + hNum[l] + hNumS[side],
                                              nProfileBins, -90., 90., Lorentz, iflag);

      m_phiVsNstrips_Side[l][side]->GetXaxis()->SetTitle("#phi to Wafer");
      m_phiVsNstrips_Side[l][side]->GetYaxis()->SetTitle("Num of Strips");

      m_phiVsNstrips_Side_100[l][side]->GetXaxis()->SetTitle("#phi to Wafer");
      m_phiVsNstrips_Side_100[l][side]->GetYaxis()->SetTitle("Num of Strips");

      m_phiVsNstrips_Side_111[l][side]->GetXaxis()->SetTitle("#phi to Wafer");
      m_phiVsNstrips_Side_111[l][side]->GetYaxis()->SetTitle("Num of Strips");
      
      
      /// 1 dimensional plots
      h_Nstrips_Side[l][side] = h1MyFactory("h_Nstrips_"+hNum[l] + "Side" + hNumS[side], "1D cluster width for layer "+hNum[l]+hNumS[side], 41, -0.5, 40.5, Lorentz, iflag);
      h_Nstrips_Side[l][side]->GetXaxis()->SetTitle("Num of strips");
      h_Nstrips_Side[l][side]->GetYaxis()->SetTitle("events");
      
      h_Nstrips_Side_100[l][side] = h1MyFactory("h_Nstrips_100_"+hNum[l] + "Side" + hNumS[side], "100 - 1D cluster width for layer "+hNum[l]+hNumS[side], 41, -0.5, 40.5, Lorentz, iflag);
      h_Nstrips_Side_100[l][side]->GetXaxis()->SetTitle("Num of strips");
      h_Nstrips_Side_100[l][side]->GetYaxis()->SetTitle("events");
      
      h_Nstrips_Side_111[l][side] = h1MyFactory("h_Nstrips_111_"+hNum[l] + "Side" + hNumS[side], "111 - 1D cluster width for layer "+hNum[l]+hNumS[side], 41, -0.5, 40.5, Lorentz, iflag);
      h_Nstrips_Side_111[l][side]->GetXaxis()->SetTitle("Num of strips");
      h_Nstrips_Side_111[l][side]->GetYaxis()->SetTitle("events");
      
      
    }
    success *= iflag;
  }
  
  
  for (int l = 0; l != nECLayers; ++l) {
      int iflag = 0;
      /// 1 dimensional histograms
    
      h_NstripsEC[l]  = h1MyFactory("h_NstripsEC_"+hNumEC[l], "1D cluster width for layer "+hNumEC[l], 41, -0.5, 40.5, Lorentz, iflag);
      h_NstripsEC[l]->GetXaxis()->SetTitle("Num of Strips");
      h_NstripsEC[l]->GetYaxis()->SetTitle("events");
      
      h_NstripsECSideA[l]  = h1MyFactory("h_NstripsECSideA_"+hNumEC[l], "1D cluster width for layer "+hNumEC[l], 41, -0.5, 40.5, Lorentz, iflag);
      h_NstripsECSideA[l]->GetXaxis()->SetTitle("Num of Strips");
      h_NstripsECSideA[l]->GetYaxis()->SetTitle("events");
      
      h_NstripsECSideC[l]  = h1MyFactory("h_NstripsECSideC_"+hNumEC[l], "1D cluster width for layer "+hNumEC[l], 41, -0.5, 40.5, Lorentz, iflag);
      h_NstripsECSideC[l]->GetXaxis()->SetTitle("Num of Strips");
      h_NstripsECSideC[l]->GetYaxis()->SetTitle("events");
      
      success *= iflag;
  }
  

  int iflag2 = 0;
  /// 1 dimensional histograms

  h_NstripsECOuter  = h1MyFactory("h_NstripsEC_Outer", "1D cluster width for Outer endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECOuter->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECOuter->GetYaxis()->SetTitle("events");

  h_NstripsECMiddle  = h1MyFactory("h_NstripsEC_Middle", "1D cluster width for Middle endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECMiddle->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECMiddle->GetYaxis()->SetTitle("events");

  h_NstripsECInner  = h1MyFactory("h_NstripsEC_Inner", "1D cluster width for Inner endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECInner->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECInner->GetYaxis()->SetTitle("events");
  
  
  
  
  
  
  h_ModuleOuter  = h1MyFactory("h_Module_Outer", "1D cluster width for Outer endcap", 120, -60.0, 60.0, Lorentz, iflag2);
  h_ModuleOuter->GetXaxis()->SetTitle("Phi");
  h_ModuleOuter->GetYaxis()->SetTitle("events");

  h_ModuleMiddle  = h1MyFactory("h_Module_Middle", "1D cluster width for Middle endcap", 120, -60.0, 60.0, Lorentz, iflag2);
  h_ModuleMiddle->GetXaxis()->SetTitle("Phi");
  h_ModuleMiddle->GetYaxis()->SetTitle("events");

  h_ModuleInner  = h1MyFactory("h_Module_Inner", "1D cluster width for Inner endcap", 120, -60.0, 60.0, Lorentz, iflag2);
  h_ModuleInner->GetXaxis()->SetTitle("Phi");
  h_ModuleInner->GetYaxis()->SetTitle("events");
  
  
  


  h_NstripsECSideAOuter  = h1MyFactory("h_NstripsECSideA_Outer", "1D cluster width for Outer endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECSideAOuter->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECSideAOuter->GetYaxis()->SetTitle("events");

  h_NstripsECSideAMiddle  = h1MyFactory("h_NstripsECSideA_Middle", "1D cluster width for Middle endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECSideAMiddle->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECSideAMiddle->GetYaxis()->SetTitle("events");

  h_NstripsECSideAInner  = h1MyFactory("h_NstripsECSideA_Inner", "1D cluster width for Inner endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECSideAInner->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECSideAInner->GetYaxis()->SetTitle("events");


  h_NstripsECSideCOuter  = h1MyFactory("h_NstripsECSideC_Outer", "1D cluster width for Outer endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECSideCOuter->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECSideCOuter->GetYaxis()->SetTitle("events");

  h_NstripsECSideCMiddle  = h1MyFactory("h_NstripsECSideC_Middle", "1D cluster width for Middle endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECSideCMiddle->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECSideCMiddle->GetYaxis()->SetTitle("events");

  h_NstripsECSideCInner  = h1MyFactory("h_NstripsECSideC_Inner", "1D cluster width for Inner endcap", 41, -0.5, 40.5, Lorentz, iflag2);
  h_NstripsECSideCInner->GetXaxis()->SetTitle("Num of Strips");
  h_NstripsECSideCInner->GetYaxis()->SetTitle("events");


  success *= iflag2;
  
  
  
  
  if (success == 0) {
    return StatusCode::FAILURE;
  }
                                                                                                                //
  // hidetoshi 14.01.22
  return StatusCode::SUCCESS;
}

TProfile *
SCTLorentzMonTool::pFactory(const std::string &name, const std::string &title, int nbinsx, float xlow, float xhigh,
                            MonGroup &registry, int &iflag) {
  Prof_t tmp = new TProfile(TString(name), TString(title), nbinsx, xlow, xhigh);
  bool success(registry.regHist(tmp).isSuccess());

  if (not success) {
    if (msgLvl(MSG::ERROR)) {
      msg(MSG::ERROR) << "Cannot book SCT histogram: " << name << endmsg;
    }
    iflag = 0;
  }else {
    iflag = 1;
  }

  return tmp;
}

bool
SCTLorentzMonTool::h1Factory(const std::string &name, const std::string &title, const float extent, MonGroup &registry,
                             VecH1_t &storageVector) {
  const unsigned int nbins(100);
  const float lo(-extent), hi(extent);
  H1_t tmp = new TH1F(TString(name), TString(title), nbins, lo, hi);
  bool success(registry.regHist(tmp).isSuccess());

  if (not success) {
    if (msgLvl(MSG::ERROR)) {
      msg(MSG::ERROR) << "Cannot book SCT histogram: " << name << endmsg;
    }
  }
  storageVector.push_back(tmp);
  return success;
}



TH1F *
SCTLorentzMonTool::h1MyFactory(const std::string & name, const std::string & title, int nbinsx, float xlow, float xhigh, MonGroup & registry, int& iflag) {
  H1_t tmp = new TH1F(TString(name), TString(title), nbinsx, xlow, xhigh);
  bool success(registry.regHist(tmp).isSuccess());

  if (not success) {
    if (msgLvl(MSG::ERROR)) {
      msg(MSG::ERROR) << "Cannot book SCT histogram: " << name << endmsg;
    }
    iflag = 0;
  }else {
    iflag = 1;
  }

  return tmp;
}


int
SCTLorentzMonTool::findAnglesToWaferSurface(const float (&vec)[3], const float &sinAlpha, const Identifier &id,
                                            float &theta, float &phi) {
  int iflag(-1);

  phi = 90.;
  theta = 90.;

  InDetDD::SiDetectorElement *element = m_sctmgr->getDetectorElement(id);
  if (!element) {
    MsgStream log(msgSvc(), name());
    log << MSG::ERROR << "findAnglesToWaferSurface:  failed to find detector element for id=" <<
    m_pSCTHelper->show_to_string(id) << endmsg;
    return iflag;
  }

  float cosAlpha = sqrt(1. - sinAlpha * sinAlpha);
  float phix = cosAlpha * element->phiAxis().x() + sinAlpha * element->phiAxis().y();
  float phiy = -sinAlpha *element->phiAxis().x() + cosAlpha * element->phiAxis().y();

  float pNormal = vec[0] * element->normal().x() + vec[1] * element->normal().y() + vec[2] * element->normal().z();
  float pEta = vec[0] * element->etaAxis().x() + vec[1] * element->etaAxis().y() + vec[2] * element->etaAxis().z();
  float pPhi = vec[0] * phix + vec[1] * phiy + vec[2] * element->phiAxis().z();

  if (pPhi < 0.) {
    phi = -90.;
  }
  if (pEta < 0.) {
    theta = -90.;
  }
  if (pNormal != 0.) {
    phi = atan(pPhi / pNormal) / CLHEP::deg;
    theta = atan(pEta / pNormal) / CLHEP::deg;
  }
  iflag = 1;
  return iflag;
}

