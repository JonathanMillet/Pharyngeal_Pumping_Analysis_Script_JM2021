%Plotting cumulative distribution for Frequency

freqCDFplot=plot(PPdata1.freqSorted,PPdata1.freqCDF,'Color','#000000','LineWidth',3);
hold on
plot(PPdata2.freqSorted,PPdata2.freqCDF,'Color','#C82929','LineWidth',3);
plot(PPdata3.freqSorted,PPdata3.freqCDF,'Color','#1C76BC','LineWidth',3);
plot(PPdata4.freqSorted,PPdata4.freqCDF,'Color','#F7941D','LineWidth',3);
plot(PPdata5.freqSorted,PPdata5.freqCDF,'Color','#2AB673','LineWidth',3);
plot(PPdata6.freqSorted,PPdata6.freqCDF,'Color','#7E2F8E','LineWidth',3);
plot(PPdata7.freqSorted,PPdata7.freqCDF,'Color','#77AC30','LineWidth',3);
plot(PPdata8.freqSorted,PPdata8.freqCDF,'Color','#D95319','LineWidth',3);
xlabel("Pharyngeal pumping Frequency (Hz)",'FontSize',30);
ylabel("Probability density",'FontSize',28);
title('Normal cumulative distribution');
set(gca,'box','off','FontSize',20);
axis ([0 6 0 1]);

%add PPdataX.name (8 max.) to the legend below

legend(PPdata1.name,PPdata2.name,"Location","southeast");
saveas(gcf,'output-PP_Frequency.pdf');
hold off

%Data table output
%add/remove % sign for the correct number of PPdata to analyze

PPdata1.tableoutput('output-PPdata1.csv');
PPdata2.tableoutput('output-PPdata2.csv');
%PPdata3.tableoutput('output-PPdata3.csv');
%PPdata4.tableoutput('output-PPdata4.csv');
%PPdata5.tableoutput('output-PPdata5.csv');
%PPdata6.tableoutput('output-PPdata6.csv');
%PPdata7.tableoutput('output-PPdata7.csv');
%PPdata8.tableoutput('output-PPdata8.csv');

%Two-sample Kolgomorov-Smirnoff test to compare two Freq distributions and assess if they are different.
%Add PPdataX.freq to tablefreq when n=90 for statistical test

tablefreq=[PPdata1.freq,PPdata2.freq,PPdata3.freq];
count=1;tablestat={zeros(28,4)};
for n=1:(size(tablefreq,2))
    for m=1:(size(tablefreq,2)-n)
        [stat_output,p_value,k_value]=kstest2(rmoutliers(tablefreq(:,n),'mean'),rmoutliers(tablefreq(:,(n+m)),'mean'));
        count=count+1;
        if stat_output==1
            tablestat(count,:)={[join([num2str(n),"vs",num2str(n+m)]);"True";p_value;k_value]};
        else
            tablestat(count,:)={[join([num2str(n),"vs",num2str(n+m)]);"False";p_value;k_value]};
        end
    end
end
clear n m p_value k_value count stat_output;
tablestat(1,:)={["Comparison";"Significant ?";"p-value";"k_value"]};
writetable(cell2table(tablestat),"output-table_stat_Frequency.csv");