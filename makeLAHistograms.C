
/*
"""
2019/12/08
Arka Santra

"""
*/

#include <iostream>
#include "TFile.h"
#include "TH1.h"
#include "TH2.h"
#include "TString.h"
#include "TCollection.h"
#include "TKey.h"
#include "TClass.h"
#include "TMath.h"
#include <string>
#include <sys/stat.h>
#include "TChain.h"
#include "TTree.h"
#include <ROOT/RDataFrame.hxx>
#include <algorithm>
#include <time.h>
#include <chrono>  // for high_resolution_clock
#include <sstream>
#include <cmath>

using namespace std;
using namespace ROOT;
using ints = ROOT::VecOps::RVec<int>;
using floats = ROOT::VecOps::RVec<float>;
bool debug = false;


void makeLAHistograms(string versionS, bool localFile){
    //### boolean to know which process should be done
    // Record start time
    auto start = std::chrono::steady_clock::now();
    ROOT::EnableImplicitMT(); 

    std::cout << "Making plots for version  " << versionS << std::endl;
    

    //### Get all relevant settings from settings.py ###
      
    string laNtupleDir = "";
    string treeInS      = "track";
    string treeInFileS  = " ";
    
    
    if(localFile){
        laNtupleDir    = "/media/arka/OS/SCTTask/ShigekiLANtuples"; /// local area in the laptop
        treeInFileS   = laNtupleDir+"/user.shhirose.19616693._000001.histograms.root"; /// local file
    }
    else{
        laNtupleDir    = "/eos/atlas/atlascerngroupdisk/det-sct/run2analysis/SCTAxAOD/output_364292/data18_13TeV.00364292.express_express"; /// in eos area of Shigeki
        treeInFileS   = laNtupleDir+"/user.shhirose.*.root"; /// file in eos from Shigeki
    }          
    
    string outputDirS     =  versionS+"/"; // the output directory

    int status            = mkdir(outputDirS.c_str(),0777);
    int status2           = mkdir((outputDirS+"LAHistograms").c_str(),0777);
    
    // convert the strings to TStrings in order to use in TFile
    TString outputDirT    = (TString)outputDirS;
    
    // creating the root files containing the weights
    
    TString laHistFileName = outputDirS+"LAHistograms/LAHistogram_"+versionS+".root";
    
    

    
    
    
     
    
    stringstream ss, ss1;
    ss << treeInS;    
    TChain chain(ss.str().c_str());
    ss1 << treeInFileS;
    chain.Add(ss1.str().c_str());
    
    
    ROOT::RDataFrame d(chain);
    //### filtering the tree to make a smaller tree, the filters should be according to the region intended. 
    
    auto dCut   = d.Filter("d0 < 1")
                   .Filter("pt > 500")
                   .Filter("nhit_SCT > 7")
                   .Filter("nhit_Pixel > 1");
                        
    string additionalSelection = "true";// these variables should be defined below in the columns
    auto count = dCut.Count();
    //# Determine the number of events to loop over
    unsigned long long rangeNumber = -1;
    
    rangeNumber = *count;
    

    //# Start loop over all events
    std::cout << "Looping over " << rangeNumber << " events" << std::endl;
    
    
    auto CalcHit = [](ints &bec, ints &clus) {
        auto clusSize = clus;
        return clusSize[bec==0];
    };
    
    auto CalcPhi = [](ints &bec, floats &phi) {
        auto phiVal = phi;
        return phiVal[bec==0];
    };
    
    
    auto dFinal = dCut.Filter("nhit > 0")
                      .Define("correctHits", CalcHit, {"hit_bec", "hit_clusize"})
                      .Define("correctHitPhi", CalcPhi, {"hit_bec","hit_localphi"});
                      //.Define("angle_hits", "return ROOT::VecOps::RVec<double>(correctHits.size(), angle);");
                      
                      //.Define("angle_holes", "return ROOT::VecOps::RVec<double>(correctHoles.size(), angle);"); /// make a scalar into a vector
                           
    auto profile_hit      = dFinal.Profile1D<ints>({"profile_hit","profile_hit",360,-18.0,18.0},"correctHitPhi","correctHits");
    auto hHit             = dFinal.Histo1D<ints>({"h_hit","h_hit",360,-18.0,18.0},"correctHits");
    auto hAngle           = dFinal.Histo1D({"h_Angle","h_Angle",360,-18.0, 18.0},"angle");
    auto hLocalPhi        = dFinal.Histo1D<floats>({"h_LocalPhi","h_LocalPhi",360,-18.0, 18.0},"correctHitPhi");
    //auto hHole            = dFinal.Histo1D<ints>({"h_hole","h_hole",360,-18.0,18.0},"correctHoles");
    
    TProfile *profileHit  = (TProfile*)profile_hit->Clone("profileHit");
    TH1F     *h_Hit       = (TH1F*)hHit->Clone("h_Hit");
    TH1F     *h_Angle     = (TH1F*)hAngle->Clone("h_Angle");
    TH1F     *h_LocalPhi  = (TH1F*)hLocalPhi->Clone("h_LocalPhi");
    
    //TH1F     *h_Hole      = (TH1F*)hHole->Clone("h_Hole");
    
    
    /// saving the alpha weights to the root file
    TFile *myFile = new TFile(laHistFileName,"RECREATE");
    myFile->cd();
    profileHit->Write();
    h_Hit->Write();
    h_Angle->Write();
    h_LocalPhi->Write();
    //h_Hole->Write();
    
    // Record end time
    auto finish = std::chrono::steady_clock::now();
    auto diff = finish - start;
    std::chrono::duration<double> elapsed = finish - start;
    std::cout << "Elapsed time : " << chrono::duration <double, milli> (diff).count()/1000.0 << " s" << endl;

}

