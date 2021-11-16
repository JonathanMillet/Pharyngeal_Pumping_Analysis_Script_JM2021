%Pump distribution
%(need to remove zeroes in the excel sheet obtained)

tablelength = max(cellfun(@numel, {PPdata1.TotalPump,PPdata2.TotalPump,PPdata3.TotalPump,PPdata4.TotalPump,PPdata5.TotalPump,PPdata6.TotalPump,PPdata7.TotalPump,PPdata8.TotalPump}));
tablemeanpumpdur = zeros(tablelength, 8);
tablename = ["","","","","","","",""];

%add/remove % sign for the correct number of PPdata to analyze

tablemeanpumpdur(1:length(PPdata1.TotalPump),1) = [PPdata1.TotalPump]; tablename(1) = [convertCharsToStrings(PPdata1.name)];
tablemeanpumpdur(1:length(PPdata2.TotalPump),2) = [PPdata2.TotalPump]; tablename(2) = [convertCharsToStrings(PPdata2.name)];
%tablemeanpumpdur(1:length(PPdata3.TotalPump),3) = [PPdata3.TotalPump]; tablename(3) = [convertCharsToStrings(PPdata3.name)];
%tablemeanpumpdur(1:length(PPdata4.TotalPump),4) = [PPdata4.TotalPump]; tablename(4) = [convertCharsToStrings(PPdata4.name)];
%tablemeanpumpdur(1:length(PPdata5.TotalPump),5) = [PPdata5.TotalPump]; tablename(5) = [convertCharsToStrings(PPdata5.name)];
%tablemeanpumpdur(1:length(PPdata6.TotalPump),6) = [PPdata6.TotalPump]; tablename(6) = [convertCharsToStrings(PPdata6.name)];
%tablemeanpumpdur(1:length(PPdata7.TotalPump),7) = [PPdata7.TotalPump]; tablename(7) = [convertCharsToStrings(PPdata7.name)];
%tablemeanpumpdur(1:length(PPdata8.TotalPump),8) = [PPdata8.TotalPump]; tablename(8) = [convertCharsToStrings(PPdata8.name)];

%add PPdataX.name (8 max) in the table below

cellmeanpumpdur = [cellstr(tablename);num2cell(tablemeanpumpdur)];
writecell(cellmeanpumpdur,"output-table_pumpDurTotal.csv");
clear tablemeanpumpdur tablelength cellmeanpumpdur;

%Plotting pump duration probability density function histogram

pumpPDFHist(PPdata1.name,PPdata1.TotalPump,'#000000','PPdata1-pumpDistHist.pdf')
pumpPDFHist(PPdata2.name,PPdata2.TotalPump,'#C82929','PPdata2-pumpDistHist.pdf')
%pumpPDFHist(PPdata3.name,PPdata3.TotalPump,'#1C76BC','PPdata3-pumpDistHist.pdf')
%pumpPDFHist(PPdata4.name,PPdata4.TotalPump,'#F7941D','PPdata4-pumpDistHist.pdf')
%pumpPDFHist(PPdata5.name,PPdata5.TotalPump,'#2AB673','PPdata5-pumpDistHist.pdf')
%pumpPDFHist(PPdata6.name,PPdata6.TotalPump,'#7E2F8E','PPdata6-pumpDistHist.pdf')
%pumpPDFHist(PPdata7.name,PPdata7.TotalPump,'#77AC30','PPdata7-pumpDistHist.pdf')
%pumpPDFHist(PPdata8.name,PPdata8.TotalPump,'#D95319','PPdata8-pumpDistHist.pdf')

%Function for probability density histogram (pump duration)

function pumpPDFHist(legendPPdata,dataTotalPump,color,name)
    histogram(dataTotalPump,'Normalization',"pdf","BinWidth",2,"LineStyle","none","FaceColor",color);
    hold on
    axis ([0 300 0 0.040]);
    xlabel("Pump duration (ms)",'FontSize',30);
    ylabel("Probability density",'FontSize',28);
    title('Probability density function of pump duration');
    set(gca,'box','off','FontSize',20);
    legend(legendPPdata,"Location","northeast");
    saveas(gcf,name);
    hold off
end