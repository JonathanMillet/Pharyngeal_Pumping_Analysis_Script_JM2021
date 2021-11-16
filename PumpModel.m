%Plotting Pump Model
%add/remove % sign for the correct number of PPdataX

plot(PPdata1.pumpModel,'Color','#000000','LineWidth',3);
hold on
plot(PPdata2.pumpModel,'Color','#C82929','LineWidth',3);
%plot(PPdata3.pumpModel,'Color','#1C76BC','LineWidth',3);
%plot(PPdata4.pumpModel,'Color','#F7941D','LineWidth',3);
%plot(PPdata5.pumpModel,'Color','#2AB673','LineWidth',3);
%plot(PPdata6.pumpModel,'Color','#7E2F8E','LineWidth',3);
%plot(PPdata7.pumpModel,'Color','#77AC30','LineWidth',3);
%plot(PPdata8.pumpModel,'Color','#D95319','LineWidth',3);
title('Pump Model'); axis off;
set(gca,'box','off','FontSize',20);

%add PPdataX.name (8 max.) to the legend below

legend(PPdata1.name,PPdata2.name,"Location","southeast")
saveas(gcf,'PumpModel.pdf');
hold off

%Statistical test for Pump Model (Welch's unequal variance t-test)
%Add PPdataX.meanDur when n=90 for statistical test

tablemeanDur=[PPdata1.meanDur,PPdata2.meanDur];
count=1;tablestatmeanDur={zeros(28,4)};
for n=1:(size(tablemeanDur,2))
    for m=1:(size(tablemeanDur,2)-n)
        [stat_output,p_value]=ttest2(rmoutliers(tablemeanDur(:,n),'mean'),rmoutliers(tablemeanDur(:,(n+m)),'mean'),'vartype','unequal');
        count=count+1;
        if stat_output==1
            tablestatmeanDur(count,:)={[join([num2str(n),"vs",num2str(n+m)]);"True";p_value]};
        else
            tablestatmeanDur(count,:)={[join([num2str(n),"vs",num2str(n+m)]);"False";p_value]};
        end
    end
end
clear n m p_value count stat_output;
tablestatmeanDur(1,:)={["Comparison";"Significant ?";"p-value"]};
writetable(cell2table(tablestatmeanDur),"output-table_stat_pump-duration.csv");

%Pump mean and Std dev

tablemean=["" "" "" "" "" "" "" "" "" ; ...
    "Mean" mean(PPdata1.TotalPump) mean(PPdata2.TotalPump) mean(PPdata3.TotalPump) mean(PPdata4.TotalPump) ...
    mean(PPdata5.TotalPump) mean(PPdata6.TotalPump) mean(PPdata7.TotalPump) mean(PPdata8.TotalPump); ...
    "Std dev" std(PPdata1.TotalPump) std(PPdata2.TotalPump) std(PPdata3.TotalPump) std(PPdata4.TotalPump) ...
    std(PPdata5.TotalPump) std(PPdata6.TotalPump) std(PPdata7.TotalPump) std(PPdata8.TotalPump)];

%add/remove % sign for the correct number of PPdataX

tablemean(1,2) = [convertCharsToStrings(PPdata1.name)];
tablemean(1,3) = [convertCharsToStrings(PPdata2.name)];
%tablemean(1,4) = [convertCharsToStrings(PPdata3.name)];
%tablemean(1,5) = [convertCharsToStrings(PPdata4.name)];
%tablemean(1,6) = [convertCharsToStrings(PPdata5.name)];
%tablemean(1,7) = [convertCharsToStrings(PPdata6.name)];
%tablemean(1,8) = [convertCharsToStrings(PPdata7.name)];
%tablemean(1,9) = [convertCharsToStrings(PPdata8.name)];

writematrix(tablemean, "PumpMeanStdDev.csv");
clear tablemean;