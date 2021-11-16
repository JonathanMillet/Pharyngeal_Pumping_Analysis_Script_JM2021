%Interpump distribution
%(need to remove zeroes in the excel sheet obtained)

tablelength = max(cellfun(@numel, {PPdata1.TotalIPI,PPdata2.TotalIPI,PPdata3.TotalIPI,PPdata4.TotalIPI,PPdata5.TotalIPI,PPdata6.TotalIPI,PPdata7.TotalIPI,PPdata8.TotalIPI}));
tablemeanIPIdur = zeros(tablelength, 8);

%add/remove % sign for the correct number of PPdata to analyze

tablemeanIPIdur(1:length(PPdata1.TotalIPI),1) = [PPdata1.TotalIPI]; tablename(1) = [convertCharsToStrings(PPdata1.name)];
tablemeanIPIdur(1:length(PPdata2.TotalIPI),2) = [PPdata2.TotalIPI]; tablename(2) = [convertCharsToStrings(PPdata2.name)];
%tablemeanIPIdur(1:length(PPdata3.TotalIPI),3) = [PPdata3.TotalIPI]; tablename(3) = [convertCharsToStrings(PPdata3.name)];
%tablemeanIPIdur(1:length(PPdata4.TotalIPI),4) = [PPdata4.TotalIPI]; tablename(4) = [convertCharsToStrings(PPdata4.name)];
%tablemeanIPIdur(1:length(PPdata5.TotalIPI),5) = [PPdata5.TotalIPI]; tablename(5) = [convertCharsToStrings(PPdata5.name)];
%tablemeanIPIdur(1:length(PPdata6.TotalIPI),6) = [PPdata6.TotalIPI]; tablename(6) = [convertCharsToStrings(PPdata6.name)];
%tablemeanIPIdur(1:length(PPdata7.TotalIPI),7) = [PPdata7.TotalIPI]; tablename(7) = [convertCharsToStrings(PPdata7.name)];
%tablemeanIPIdur(1:length(PPdata8.TotalIPI),8) = [PPdata8.TotalIPI]; tablename(8) = [convertCharsToStrings(PPdata8.name)];

%add PPdataX.name (8 max) in the table below

cellmeanIPIdur = [cellstr(tablename);num2cell(tablemeanIPIdur)];
writecell(cellmeanIPIdur,"output-table_IPIDurTotal.csv");
clear tablemeanIPIdur tablelength tablename cellmeanIPIdur;

%Plotting IPI probability density function histogram

IPIPDFHist(PPdata1.name,PPdata1.TotalIPI,'#000000','PPdata1-IPIDistHist.pdf')
IPIPDFHist(PPdata2.name,PPdata2.TotalIPI,'#C82929','PPdata2-IPIDistHist.pdf')
%IPIPDFHist(PPdata3.name,PPdata3.TotalIPI,'#1C76BC','PPdata3-IPIDistHist.pdf')
%IPIPDFHist(PPdata4.name,PPdata4.TotalIPI,'#F7941D','PPdata4-IPIDistHist.pdf')
%IPIPDFHist(PPdata5.name,PPdata5.TotalIPI,'#2AB673','PPdata5-IPIDistHist.pdf')
%IPIPDFHist(PPdata6.name,PPdata6.TotalIPI,'#7E2F8E','PPdata6-IPIDistHist.pdf')
%IPIPDFHist(PPdata7.name,PPdata7.TotalIPI,'#77AC30','PPdata7-IPIDistHist.pdf')
%IPIPDFHist(PPdata8.name,PPdata8.TotalIPI,'#D95319','PPdata8-IPIDistHist.pdf')

%Function for probability density histogram (InterPump Interval)

function IPIPDFHist(legendPPdata,dataTotalIPI,color,name)
    histogram(dataTotalIPI,'Normalization',"pdf","NumBins",60,"FaceColor",color);
    hold on
    axis ([0 400 0 0.030]);
    xlabel("Interpump Interval (ms)",'FontSize',30);
    ylabel("Probability density",'FontSize',28);
    title('Probability density function of IPI');
    set(gca,'box','off','FontSize',20);
    legend(legendPPdata,"Location","northeast");
    saveas(gcf,name);
    hold off
end