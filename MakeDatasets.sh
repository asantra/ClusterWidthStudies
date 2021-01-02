#! /bin/bash

### this is to make datasets

#######################################################
#### the luminosity block with contamination from each HV block has been removed on August 4, 2017.
#### This was done to avoid the contamination of other voltages, because the starting luminosity block may contain some of the data points from previous HV.
#######################################################

date="August7_2017"


### work with Run 284484
rucio add-dataset user.asantra.data15_13TeV.00284484.10V.physics_Main_$date.daq.RAW
# Add files of LBs 24-33 to the new data set 
# This command takes more than 10 minutes
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0106\|lb0107\|lb0108\|lb0109\|lb0110\|lb0111\|lb0112\|lb0113\|lb0114\|lb0115' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.10V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data15_13TeV.00284484.20V.physics_Main_$date.daq.RAW
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0091\|lb0092\|lb0093\|lb0094\|lb0095\|lb0096\|lb0097\|lb0098\|lb0099\|lb0100\|lb0101\|lb0102' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.20V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data15_13TeV.00284484.30V.physics_Main_$date.daq.RAW
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0080\|lb0081\|lb0082\|lb0083\|lb0084\|lb0085\|lb0086\|lb0087\|lb0088\|lb0089' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.30V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data15_13TeV.00284484.40V.physics_Main_$date.daq.RAW
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0069\|lb0070\|lb0071\|lb0072\|lb0073\|lb0074\|lb0075\|lb0076\|lb0077\|lb0078' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.40V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data15_13TeV.00284484.50V.physics_Main_$date.daq.RAW
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0058\|lb0059\|lb0060\|lb0061\|lb0062\|lb0063\|lb0064\|lb0065\|lb0066\|lb0067' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.50V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data15_13TeV.00284484.75V.physics_Main_$date.daq.RAW
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0047\|lb0048\|lb0049\|lb0050\|lb0051\|lb0052\|lb0053\|lb0054\|lb0055\|lb0056' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.75V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data15_13TeV.00284484.100V.physics_Main_$date.daq.RAW
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0036\|lb0037\|lb0038\|lb0039\|lb0040\|lb0041\|lb0042\|lb0043\|lb0044\|lb0045' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.100V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data15_13TeV.00284484.150V.physics_Main_$date.daq.RAW
for i in `rucio ls data15_13TeV.00284484.physics_Main.daq.RAW | grep 'lb0164\|lb0165\|lb0166\|lb0167\|lb0168\|lb0169\|lb0170\|lb0171\|lb0172\|lb0173' | awk '{print$2}'`; do rucio attach user.asantra.data15_13TeV.00284484.150V.physics_Main_$date.daq.RAW $i; done




#### Work with run 309375


rucio add-dataset user.asantra.data16_13TeV.00309375.5V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0289\|lb0290\|lb0291\|lb0292\|lb0293\|lb0294\|lb0295\|lb0296\|lb0297\|lb0298' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.5V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data16_13TeV.00309375.10V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0278\|lb0279\|lb0280\|lb0281\|lb0282\|lb0283\|lb0284\|lb0285\|lb0286\|lb0287' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.10V.physics_Main_$date.daq.RAW $i; done



rucio add-dataset user.asantra.data16_13TeV.00309375.20V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0269\|lb0270\|lb0271\|lb0272\|lb0273\|lb0274\|lb0275\|lb0276' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.20V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data16_13TeV.00309375.30V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0259\|lb0260\|lb0261\|lb0262\|lb0263\|lb0264\|lb0265\|lb0266\|lb0267' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.30V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data16_13TeV.00309375.40V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0249\|lb0250\|lb0251\|lb0252\|lb0253\|lb0254\|lb0255\|lb0256\|lb0257' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.40V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data16_13TeV.00309375.50V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0241\|lb0242\|lb0243\|lb0244\|lb0245\|lb0246\|lb0247\|lb0248' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.50V.physics_Main_$date.daq.RAW $i; done ### may start from lb0239


rucio add-dataset user.asantra.data16_13TeV.00309375.75V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0228\|lb0229\|lb0230\|lb0231\|lb0232\|lb0233\|lb0234\|lb0235\|lb0236\|lb0237' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.75V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data16_13TeV.00309375.100V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0219\|lb0220\|lb0221\|lb0222\|lb0223\|lb0224\|lb0225\|lb0226' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.100V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data16_13TeV.00309375.125V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0207\|lb0208\|lb0209\|lb0210\|lb0211\|lb0212\|lb0213\|lb0214\|lb0215\|lb0216' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.125V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data16_13TeV.00309375.150V.physics_Main_$date.daq.RAW
for i in `rucio ls data16_13TeV.00309375.physics_Main.daq.RAW | grep 'lb0190\|lb0191\|lb0192\|lb0193\|lb0194\|lb0195\|lb0196\|lb0197\|lb0198\|lb0199\|lb0200\|lb0201\|lb0202\|lb0203\|lb0204\|lb0205' | awk '{print$2}'`; do rucio attach user.asantra.data16_13TeV.00309375.150V.physics_Main_$date.daq.RAW $i; done



#### Work with run 324502


rucio add-dataset user.asantra.data17_13TeV.00324502.5V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0700\|lb0701\|lb0702\|lb0703\|lb0704\|lb0705\|lb0706' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.5V.physics_Main_$date.daq.RAW $i; done



rucio add-dataset user.asantra.data17_13TeV.00324502.10V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0694\|lb0695\|lb0696\|lb0697\|lb0698' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.10V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.20V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0688\|lb0689\|lb0690\|lb0691\|lb0692' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.20V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.30V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0682\|lb0683\|lb0684\|lb0685\|lb0686' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.30V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.40V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0672\|lb0673\|lb0674\|lb0675\|lb0676\|lb0677\|lb0678\|lb0679\|lb0680' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.40V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.50V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0662\|lb0663\|lb0664\|lb0665\|lb0666\|lb0667\|lb0668\|lb0669\|lb0670' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.50V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data17_13TeV.00324502.75V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0652\|lb0653\|lb0654\|lb0655\|lb0656\|lb0657\|lb0658\|lb0659\|lb0660' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.75V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data17_13TeV.00324502.100V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0644\|lb0645\|lb0646\|lb0647\|lb0648\|lb0649\|lb0650' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.100V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data17_13TeV.00324502.125V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0633\|lb0634\|lb0635\|lb0636\|lb0637\|lb0638\|lb0639\|lb0640\|lb0641\|lb0642' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.125V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data17_13TeV.00324502.150V.physics_Main_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0708\|lb0709' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.150V.physics_Main_$date.daq.RAW $i; done







### 324502 B6 data

rucio add-dataset user.asantra.data17_13TeV.00324502.150V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0751\|lb0752\|lb0753\|lb0754\|lb0755' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.150V.physics_Main_B6_$date.daq.RAW $i; done



rucio add-dataset user.asantra.data17_13TeV.00324502.125V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0711\|lb0712\|lb0713\|lb0714\|lb0715' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.125V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.100V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0717\|lb0718\|lb0719\|lb0720\|lb0721' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.100V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.75V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0723\|lb0724\|lb0725' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.75V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.50V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0727\|lb0728\|lb0729' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.50V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.40V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0731\|lb0732\|lb0733' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.40V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.30V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0735\|lb0736\|lb0737' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.30V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.20V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0739\|lb0740\|lb0741' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.20V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.10V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0743\|lb0744\|lb0745' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.10V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00324502.5V.physics_Main_B6_$date.daq.RAW
for i in `rucio ls data17_13TeV.00324502.physics_Main.daq.RAW | grep 'lb0747\|lb0748\|lb0749' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00324502.5V.physics_Main_B6_$date.daq.RAW $i; done



## 218224 2013 data



rucio add-dataset user.asantra.data13_hip.00218224.50V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218224.physics_MinBias.merge.RAW | grep 'lb0257\|lb0258\|lb0259\|lb0260\|lb0261\|lb0262\|lb0263\|lb0264' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218224.50V.physics_MinBias_Merge_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data13_hip.00218224.60V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218224.physics_MinBias.merge.RAW | grep 'lb0267\|lb0268\|lb0269\|lb0270\|lb0271\|lb0272\|lb0273\|lb0274' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218224.60V.physics_MinBias_Merge_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data13_hip.00218224.70V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218224.physics_MinBias.merge.RAW | grep 'lb0277\|lb0278\|lb0279\|lb0280\|lb0281\|lb0282\|lb0283\|lb0284' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218224.70V.physics_MinBias_Merge_$date.daq.RAW $i; done ## lb0276 can be added


rucio add-dataset user.asantra.data13_hip.00218224.80V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218224.physics_MinBias.merge.RAW | grep 'lb0286\|lb0287\|lb0288\|lb0289\lb0290' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218224.80V.physics_MinBias_Merge_$date.daq.RAW $i; done


 
### 218279 2013 data
 
rucio add-dataset user.asantra.data13_hip.00218279.80V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218279.physics_MinBias.merge.RAW | grep 'lb0166\|lb0167\|lb0168\|lb0169\|lb0170\|lb0171\|lb0172\|lb0173\|lb0174' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218279.80V.physics_MinBias_Merge_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data13_hip.00218279.90V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218279.physics_MinBias.merge.RAW | grep 'lb0176\|lb0177\|lb0178\|lb0179\|lb0180\|lb0181\|lb0182\|lb0183\|lb0184' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218279.90V.physics_MinBias_Merge_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data13_hip.00218279.100V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218279.physics_MinBias.merge.RAW | grep 'lb0186\|lb0187\|lb0188\|lb0189\|lb0190\|lb0191\|lb0192\|lb0193' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218279.100V.physics_MinBias_Merge_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data13_hip.00218279.110V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218279.physics_MinBias.merge.RAW | grep 'lb0196\|lb0197\|lb0198\|lb0199\|lb0200' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218279.110V.physics_MinBias_Merge_$date.daq.RAW $i; done



rucio add-dataset user.asantra.data13_hip.00218279.120V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218279.physics_MinBias.merge.RAW | grep 'lb0202\|lb0203\|lb0204\|lb0205\|lb0206' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218279.120V.physics_MinBias_Merge_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data13_hip.00218279.130V.physics_MinBias_Merge_$date.daq.RAW
for i in `rucio ls data13_hip.00218279.physics_MinBias.merge.RAW | grep 'lb0208\|lb0209\|lb0210\|lb0211\|lb0212' | awk '{print$2}'`; do rucio attach user.asantra.data13_hip.00218279.130V.physics_MinBias_Merge_$date.daq.RAW $i; done




#### Work with run 340072

rucio add-dataset user.asantra.data17_13TeV.00340072.150V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1201\|lb1202\|lb1203\|lb1204\|lb1205' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.150V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data17_13TeV.00340072.125V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1211\|lb1212\|lb1213\|lb1214\|lb1215' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.125V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.100V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1217\|lb1218\|lb1219\|lb1220' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.100V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.75V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1222\|lb1223\|lb1224\|lb1225' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.75V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.50V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1227\|lb1228\|lb1229\|lb1230' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.50V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.40V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1232\|lb1233\|lb1234\|lb1235' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.40V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.30V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1237\|lb1238\|lb1239\|lb1240' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.30V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.20V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1242\|lb1243\|lb1244\|lb1245' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.20V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.10V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1247\|lb1248\|lb1249\|lb1250' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.10V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.5V.physics_Main_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1252\|lb1253\|lb1254\|lb1255' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.5V.physics_Main_$date.daq.RAW $i; done







### working with run 340072, Barrel 6



rucio add-dataset user.asantra.data17_13TeV.00340072.150V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1312\|lb1313\|lb1314\|lb1315\|lb1316' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.150V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.125V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1262\|lb1263\|lb1264\|lb1265\|lb1266' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.125V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.100V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1268\|lb1269\|lb1270\|lb1271' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.100V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.75V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1273\|lb1274\|lb1275\|lb1276' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.75V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.50V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1278\|lb1279\|lb1280\|lb1281' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.50V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.40V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1283\|lb1284\|lb1285\|lb1286' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.40V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.30V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1288\|lb1289\|lb1290\|lb1291' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.30V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.20V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1293\|lb1294\|lb1295\|lb1296' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.20V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.10V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1298\|lb1299\|lb1300\|lb1301' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.10V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.5V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1303\|lb1304\|lb1305\|lb1306' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.5V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340072.2V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data17_13TeV.00340072.physics_Main.daq.RAW | grep 'lb1308\|lb1309' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340072.2V.physics_Main_B6_$date.daq.RAW $i; done











 
#### Work with run 348251 B3


rucio add-dataset user.asantra.data18_13TeV.00348251.5V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0378\|lb0379\|lb0380\|lb0381' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.5V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.10V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0373\|lb0374\|lb0375\|lb0376' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.10V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.20V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0368\|lb0369\|lb0370\|lb0371' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.20V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.30V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0363\|lb0364\|lb0365\|lb0366' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.30V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.40V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0358\|lb0359\|lb0360\|lb0361' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.40V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.50V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0353\|lb0354\|lb0355\|lb0356' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.50V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.75V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0348\|lb0349\|lb0350\|lb0351' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.75V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00348251.100V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0343\|lb0344\|lb0345\|lb0346' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.100V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.125V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0338\|lb0339\|lb0340\|lb0341' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.125V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.150V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0383\|lb0384\|lb0385\|lb0386' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.150V.physics_Main_$date.daq.RAW $i; done




#### Work with run 348251 B6


rucio add-dataset user.asantra.data18_13TeV.00348251.5V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0321\|lb0322\|lb0323\|lb0324' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.5V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.10V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0316\|lb0317\|lb0318\|lb0319' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.10V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.20V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0311\|lb0312\|lb0313\|lb0314' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.20V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.30V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0306\|lb0307\|lb0308\|lb0309' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.30V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.40V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0301\|lb0302\|lb0303\|lb0304' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.40V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.50V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0296\|lb0297\|lb0298\|lb0299' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.50V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.75V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0290\|lb0291\|lb0292\|lb0293' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.75V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00348251.100V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0285\|lb0286\|lb0287\|lb0288' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.100V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.125V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0278\|lb0279\|lb0280\|lb0281' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.125V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00348251.150V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00348251.physics_Main.daq.RAW | grep 'lb0329\|lb0330\|lb0331' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00348251.150V.physics_Main_B6_$date.daq.RAW $i; done



########### new run for 2018, 361689

rucio add-dataset user.asantra.data18_13TeV.00361689.250V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0159\|lb0160' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.250V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.200V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0174\|lb0175\|lb0176' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.200V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.180V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0182\|lb0183' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.180V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00361689.160V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0186\|lb0187' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.160V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.140V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0189\|lb0190' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.140V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.120V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0193\|lb0194' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.120V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.100V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0197\|lb0198' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.100V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.80V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0204\|lb0205' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.80V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.60V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0207\|lb0208' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.60V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00361689.40V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00361689.physics_Main.daq.RAW | grep 'lb0211\|lb0212' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00361689.40V.physics_Main_$date.daq.RAW $i; done



########### new run for 2018, 363664

rucio add-dataset user.asantra.data18_13TeV.00363664.10V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0768\|lb0769' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.10V.physics_Main_$date.daq.RAW $i; done



rucio add-dataset user.asantra.data18_13TeV.00363664.20V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0771\|lb0772' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.20V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.30V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0775\|lb0776' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.30V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.40V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0779\|lb0780' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.40V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.50V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0783\|lb0784' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.50V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.60V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0786\|lb0787' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.60V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.80V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0790\|lb0791' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.80V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.100V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0793\|lb0794' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.100V.physics_Main_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00363664.120V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0797\|lb0798' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.120V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.140V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0801\|lb0802' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.140V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.160V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0805\|lb0806' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.160V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.180V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0809\|lb0810' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.180V.physics_Main_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00363664.200V.physics_Main_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00363664.physics_Main.daq.RAW | grep 'lb0813\|lb0814' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00363664.200V.physics_Main_$date.daq.RAW $i; done












########### new run for 2018, 360414  ### only B6, these are without the transition impurity, so begining and ending LBs were not included

rucio add-dataset user.asantra.data18_13TeV.00360414.30V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0111\|lb0112\|lb0113\|lb0114\|lb0115\|lb0116\|lb0117\|lb0118\|lb0119\|lb0120\|lb0121' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.30V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00360414.40V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0078\|lb0079\|lb0080' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.40V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00360414.60V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0070\|lb0071\|lb0072\|lb0073\|lb0074' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.60V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00360414.80V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0063\|lb0064\|lb0065' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.80V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00360414.100V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0054\|lb0055\|lb0056\|lb0057' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.100V.physics_Main_B6_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_13TeV.00360414.120V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0045\|lb0046\|lb0047\|lb0048\|lb0049' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.120V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00360414.130V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0032\|lb0033\|lb0034\|lb0035\|lb0036\|lb0037\|lb0038\|lb0039' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.130V.physics_Main_B6_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00360414.140V.physics_Main_B6_$date.daq.RAW
for i in `rucio list-files data18_13TeV.00360414.physics_Main.daq.RAW | grep 'lb0019\|lb0020\|lb0021\|lb0022\|lb0023' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360414.140V.physics_Main_B6_$date.daq.RAW $i; done






########## new run for 2018, 367170  ### only B6, these are without the transition impurity, so begining and ending LBs were not included

rucio add-dataset user.asantra.data18_hi.00367170.100V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0550\|lb0551' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.100V.physics_HardProbes_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_hi.00367170.110V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0543\|lb0544' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.110V.physics_HardProbes_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_hi.00367170.120V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0538\|lb0539' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.120V.physics_HardProbes_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_hi.00367170.130V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0531\|lb0532' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.130V.physics_HardProbes_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_hi.00367170.140V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0555\|lb0556' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.140V.physics_HardProbes_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_hi.00367170.150V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0527' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.150V.physics_HardProbes_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_hi.00367170.170V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0561\|lb0562' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.170V.physics_HardProbes_$date.daq.RAW $i; done

rucio add-dataset user.asantra.data18_hi.00367170.200V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0518\|lb0519\|lb0520\|lb0521' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.200V.physics_HardProbes_$date.daq.RAW $i; done


rucio add-dataset user.asantra.data18_hi.00367170.250V.physics_HardProbes_$date.daq.RAW
for i in `rucio list-files data18_hi.00367170.physics_HardProbes.daq.RAW | grep 'lb0513\|lb0514\|lb0515' | awk '{print$2}'`; do rucio attach user.asantra.data18_hi.00367170.250V.physics_HardProbes_$date.daq.RAW $i; done



########### needed for Lorentz Angle studies ##############
rucio add-dataset user.asantra.data11_7TeV.00184130.AllV.physics_Express_$date.daq.RAW
for i in `rucio list-files data11_7TeV.00184130.express_express.merge.NTUP_SCT.f387_m895 | grep '_0001\|_0002\|_0003\|_0004\|_0005\|_0006\|_0007\|_0008\|_0009\|_0010\|_0011\|_0012\|_0013\|_0014\|_0015\|_0016\|_0017\|_0018\|_0019\|_0020\|_0021\|_0022\|_0023\|_0024\|_0025\|_0026\|_0027\|_0028\|_0029\|_0030\|_0031\|_0032\|_0033\|_0034\|_0035\|_0036\|_0037\|_0038\|_0039\|_0040\|_0041\|_0042' | awk '{print$2}'`; do rucio attach user.asantra.data11_7TeV.00184130.AllV.physics_Express_$date.daq.RAW $i; done


########## needed for Lorentz Angle studies ##############
rucio add-dataset user.asantra.data18_13TeV.00351364.AllV.physics_Main_part2.daq.RAW
for i in `rucio list-files data18_13TeV.00351364.physics_Main.daq.RAW | grep 'lb0073\|lb0074\|lb0075\|lb0076\|lb0077' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00351364.AllV.physics_Main_part2.daq.RAW $i; done


rucio add-dataset user.asantra.data17_13TeV.00340453.AllV.physics_Main.daq.RAW
for i in `rucio list-files data17_13TeV.00340453.physics_Main.daq.RAW | grep 'lb0080\|lb0081\|lb0082\|lb0083\|lb0084\|lb0085\|lb0086' | awk '{print$2}'`; do rucio attach user.asantra.data17_13TeV.00340453.AllV.physics_Main.daq.RAW $i; done


rucio add-dataset user.asantra.data18_13TeV.00360026.150V.physics_Main.daq.RAW
for i in `rucio list-files data18_13TeV.00360026.physics_Main.daq.RAW | grep 'lb0100\|lb0101\|lb0102\|lb0103\|lb0104\|lb0105\|lb0106\|lb0107\|lb0108\|lb0109\|lb0110\|lb0111\|lb0112\|lb0113\|lb0114\|lb0115\|lb0116\|lb0117\|lb0118\|lb0119\|lb0120\|lb0121\|lb0122\|lb0123\|lb0124\|lb0125\|lb0126\|lb0127\|lb0128\|lb0129\|lb0130\|lb0131\|lb0132\|lb0133\|lb0134\|lb0135\|lb0136\|lb0137\|lb0138\|lb0139\|lb0140\|lb0141\|lb0142\|lb0143\|lb0144\|lb0145\|lb0146\|lb0147\|lb0148\|lb0149\|lb0150\|lb0151\|lb0152\|lb0153\|lb0154\|lb0155\|lb0156\|lb0157\|lb0158\|lb0159\|lb0160' | awk '{print$2}'`; do rucio attach user.asantra.data18_13TeV.00360026.150V.physics_Main.daq.RAW $i; done

##user.asantra.data18_13TeV.00360026.150V.physics_Main.daq.RAW






