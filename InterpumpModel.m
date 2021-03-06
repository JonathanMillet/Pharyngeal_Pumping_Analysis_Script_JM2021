%Plotting InterPump Model
%add/remove % sign for the correct number of PPdataX

plot(PPdata1.IPIModel,'Color','#000000','LineWidth',3);
hold on
plot(PPdata2.IPIModel,'Color','#C82929','LineWidth',3);
plot(PPdata3.IPIModel,'Color','#1C76BC','LineWidth',3);
plot(PPdata4.IPIModel,'Color','#F7941D','LineWidth',3);
plot(PPdata5.IPIModel,'Color','#2AB673','LineWidth',3);
%plot(PPdata6.IPIModel,'Color','#7E2F8E','LineWidth',3);
%plot(PPdata7.IPIModel,'Color','#77AC30','LineWidth',3);
%plot(PPdata8.IPIModel,'Color','#D95319','LineWidth',3);
title('InterPump Interval Model'); axis off;
set(gca,'box','off','FontSize',20);

%add PPdataX.name (8 max.) to the legend below

legend(PPdata1.name,PPdata2.name,PPdata3.name,PPdata4.name,PPdata5.name,"Location","southeast")
saveas(gcf,'InterPumpIntervalModel.pdf');
hold off

%Statistical test for InterPump Interval Model (Welch's unequal variance t-test)
%Add PPdataX.IPIDur when n=90 for statistical test

tableIPIDur=[PPdata1.IPIDur,PPdata2.IPIDur,PPdata3.IPIDur,PPdata4.IPIDur,PPdata5.IPIDur];
count=1;tablestatIPIDur={zeros(28,4)};
for n=1:(size(tableIPIDur,2))
    for m=1:(size(tableIPIDur,2)-n)
        [stat_output,p_value]=ttest2(rmoutliers(tableIPIDur(:,n),'mean'),rmoutliers(tableIPIDur(:,(n+m)),'mean'),'vartype','unequal');
        count=count+1;
        if stat_output==1
            tablestatIPIDur(count,:)={[join([num2str(n),"vs",num2str(n+m)]);"True";p_value]};
        else
            tablestatIPIDur(count,:)={[join([num2str(n),"vs",num2str(n+m)]);"False";p_value]};
        end
    end
end
clear n m p_value count stat_output;
tablestatIPIDur(1,:)={["Comparison";"Significant ?";"p-value"]};
writetable(cell2table(tablestatIPIDur),"output-table_stat_IPI-duration.csv");

%Interpump mean and Std dev
%add/remove % sign for the correct number of PPdataX

PPdata1.cleanIPIdur();
PPdata2.cleanIPIdur();
PPdata3.cleanIPIdur();
PPdata4.cleanIPIdur();
PPdata5.cleanIPIdur();
%PPdata6.cleanIPIdur();
%PPdata7.cleanIPIdur();
%PPdata8.cleanIPIdur();

tablemean=["" "" "" "" "" "" "" "" "" ; ...
    "Mean" mean(PPdata1.IPIDur) mean(PPdata2.IPIDur) mean(PPdata3.IPIDur) mean(PPdata4.IPIDur) ...
    mean(PPdata5.IPIDur) mean(PPdata6.IPIDur) mean(PPdata7.IPIDur) mean(PPdata8.IPIDur); ...
    "Std dev" std(PPdata1.IPIDur) std(PPdata2.IPIDur) std(PPdata3.IPIDur) std(PPdata4.IPIDur) ...
    std(PPdata5.IPIDur) std(PPdata6.IPIDur) std(PPdata7.IPIDur) std(PPdata8.IPIDur)];

%add/remove % sign for the correct number of PPdataX

tablemean(1,2) = [convertCharsToStrings(PPdata1.name)];
tablemean(1,3) = [convertCharsToStrings(PPdata2.name)];
tablemean(1,4) = [convertCharsToStrings(PPdata3.name)];
tablemean(1,5) = [convertCharsToStrings(PPdata4.name)];
tablemean(1,6) = [convertCharsToStrings(PPdata5.name)];
%tablemean(1,7) = [convertCharsToStrings(PPdata6.name)];
%tablemean(1,8) = [convertCharsToStrings(PPdata7.name)];
%tablemean(1,9) = [convertCharsToStrings(PPdata8.name)];

writematrix(tablemean, "IPIMeanStdDev.csv");
clear tablemean;