import os, sys, re, time, commands, getopt
import argparse
from ROOT import *
from copy import copy, deepcopy
#sys.path.insert(0, '/mnt/droplet/home/arka/arka/include')
#sys.path.insert(0, '/home/arka/arka/include')


#from Functions import * 

def MakeLine(xlow, ylow, xup, yup):
  line = TLine(xlow,ylow,xup,yup)
  line.SetLineStyle(2)
  return line

def MakeLatex(xPoint, yPoint, latexName):
    tex = TLatex(xPoint, yPoint,latexName)
    tex.SetNDC()
    tex.SetTextAlign(31)
    tex.SetTextFont(42)
    tex.SetTextSize(0.044)
    tex.SetLineWidth(2)
    return tex

### the fitting function
def myfunc(xLow, xHigh):
    lorentzAngleFunction = "([0]*(TMath::Tan(x) - TMath::Tan([1]))+[2])"
    gaussianFunction     = "(TMath::Exp(-0.5*((x)/[3])^2))"
    functionStr          = lorentzAngleFunction+"#otimes"+gaussianFunction
    
    f_conv               = TF1Convolution(lorentzAngleFunction, gaussianFunction, xLow, xHigh, True);
    
    f_conv.SetRange(xLow, xHigh);
    f_conv.SetNofPointsFFT(1000);
    
    functionDef = TF1("functionDef",f_conv, xLow, xHigh, f_conv.GetNpar());
    #f->SetParameters(1.,-0.3,0.,1.);
    
    return [functionDef, functionStr]


def DrawCanvas(graph, canvasName, xLow=-10.0, xHigh=10.0, LatexName='', LatexName2='', LatexName3=''):
    
    Tex = MakeLatex(0.70,0.30,LatexName)
    Tex1 = MakeLatex(0.70,0.25,"Fit function")
    Tex2 = MakeLatex(0.90,0.20,LatexName2)
    Tex3 = MakeLatex(0.90,0.15,LatexName3)
    directory = "FitResults"
    if not os.path.exists(directory):
        os.makedirs(directory)
        
    canvas    = TCanvas("firstFit", "firstFitToTGraph", 1024, 768)
    gStyle.SetOptStat(0)
    gStyle.SetOptFit(1111)
    gStyle.SetStatY(0.9);                
    #// Set y-position (fraction of pad size)
    gStyle.SetStatX(0.9);                
    #// Set x-position (fraction of pad size)
    gStyle.SetStatW(0.2);                
    #// Set width of stat-box (fraction of pad size)
    gStyle.SetStatH(0.1);                
    #// Set height of stat-box (fraction of pad size)
    graph.SetMarkerStyle(kFullDotLarge)
    graph.SetTitle("Finding Lorentz Angle")
    graph.GetXaxis().SetTitle("#phi to Wafer [degree]") # set x-axis title
    graph.GetXaxis().SetRangeUser(xLow, xHigh)
    graph.GetYaxis().SetTitle("new cluster width") # set y-axis title
    graph.GetYaxis().SetRangeUser(0.0,3.0) # set y-axis range
    gPad.SetTickx()
    gPad.SetTicky()
    graph.Draw()
    
    Tex.Draw("sames")
    Tex1.Draw("sames")
    Tex2.Draw("sames")
    Tex3.Draw("sames")
    #line.Draw("sames")
    canvas.SaveAs(directory+"/"+canvasName+".png")
    canvas.SaveAs(directory+"/"+canvasName+".pdf")
    
    
    
def fitCurve(graph, function):
    graph.Fit(function,"R")

    ndf       = function.GetNDF()
    chiSquare = function.GetChisquare()
    result    = str(chiSquare)+"/"+str(ndf)

    print "fit result: ", result
    return deepcopy(graph)
    
def main():
     
    ### take the argument from command line
    parser = argparse.ArgumentParser()
    parser.add_argument('-run','--runNumber',type=int, default=184130)
    parser.add_argument('-r1','--xRangeLow', type=float, default=-20.0)
    parser.add_argument('-r2','--xRangeHigh',type=float, default=10.0)
    parser.add_argument('--b6', dest='needB6', action='store_true')
    args = parser.parse_args()
    
    directoryName   = "LatestInputFiles"
    fileName        = "HIST_Run184130_NOneRawFile_v2.root"
    
    histFile        = TFile(fileName, "READ")
    runValue        = "/run_"+str(args.runNumber)
    
    dirAddress      = gDirectory.Get(runValue+"/SCT/GENERAL/lorentz")
    
    if (args.needB6):
        h_LorentzAngle  = dirAddress.Get("h_phiVsNstrips3")
        stringB         = "B6"
    else:
        h_LorentzAngle  = dirAddress.Get("h_phiVsNstrips0")
        stringB         = "B3"
    
    #### all the graphs ####
    #totalFit       = TF1("totalFit", myfunc(args.xRangeLow, args.xRangeHigh), args.xRangeLow, args.xRangeHigh)
    fitFunction    = myfunc(args.xRangeLow, args.xRangeHigh)[0]
    
    fitFunction.SetParameters(0, -1000.0, 1000.0)
    fitFunction.SetParameters(1, -10.0, 0.0)
    fitFunction.SetParameters(2, -1000.0, 1000.0)
    fitFunction.SetParameters(3, -1000.0, 1000.0)
    fitFunction.SetParameters(4, -1000.0, 1000.0)
    fitFunction.SetParameters(5, -1000.0, 1000.0)
    fitFunction.SetParameters(6, -1000.0, 1000.0)
    
    functionString = myfunc(args.xRangeLow, args.xRangeHigh)[1]
    functionString = functionString.replace("TMath::","")
    
    fitGraph       = fitCurve(h_LorentzAngle, fitFunction)
    DrawCanvas(fitGraph, "LorentzAngleFit_Run"+str(args.runNumber)+stringB, args.xRangeLow, args.xRangeHigh, "Run "+str(args.runNumber)+", All #eta, "+stringB, functionString)
    
if __name__ == "__main__":
    start = time.time()
    main()
    print "Time taken: ", time.time() - start, " s"


