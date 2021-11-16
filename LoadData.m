%Loading files to be analyzed and declaring variables

clear;close all;clc;
PPdata1=PPdataClass;PPdata2=PPdataClass;PPdata3=PPdataClass;
PPdata4=PPdataClass;PPdata5=PPdataClass;PPdata6=PPdataClass;
PPdata7=PPdataClass;PPdata8=PPdataClass;

%add/remove % sign for the correct number of PPdata to analyze

PPdata1.loadPPdata('Cond1_1.xls','Cond1_2.xls','Cond1_3.xls');
PPdata2.loadPPdata('Cond2_1.xls','Cond2_2.xls','Cond2_3.xls');
PPdata3.loadPPdata('Cond3_1.xls','Cond3_2.xls','Cond3_3.xls');
%PPdata4.loadPPdata('Cond4_1.xls','Cond4_2.xls','Cond4_3.xls');
%PPdata5.loadPPdata('Cond5_1.xls','Cond5_2.xls','Cond5_3.xls');
%PPdata6.loadPPdata('Cond6_1.xls','Cond6_2.xls','Cond6_3.xls');
%PPdata7.loadPPdata('Cond7_1.xls','Cond7_2.xls','Cond7_3.xls');
%PPdata8.loadPPdata('Cond8_1.xls','Cond8_2.xls','Cond8_3.xls');