%Pump kernel distribution
%add/remove % sign for the correct number of PPdata to analyze

[PPdata1pump80, PPdata1pump110, PPdata1ratio80over110, PPdata1ratio110over80] = pumpKernel(PPdata1.name,PPdata1.TotalPump,'#000000','PPdata1-pumpKernel.pdf');
[PPdata2pump80, PPdata2pump110, PPdata2ratio80over110, PPdata2ratio110over80] = pumpKernel(PPdata2.name,PPdata2.TotalPump,'#C82929','PPdata2-pumpKernel.pdf');
[PPdata3pump80, PPdata3pump110, PPdata3ratio80over110, PPdata3ratio110over80] = pumpKernel(PPdata3.name,PPdata3.TotalPump,'#1C76BC','PPdata3-pumpKernel.pdf');
%[PPdata4pump80, PPdata4pump110, PPdata4ratio80over110, PPdata4ratio110over80] = pumpKernel(PPdata4.name,PPdata4.TotalPump,'#F7941D','PPdata4-pumpKernel.pdf');
%[PPdata5pump80, PPdata5pump110, PPdata5ratio80over110, PPdata5ratio110over80] = pumpKernel(PPdata5.name,PPdata5.TotalPump,'#2AB673','PPdata5-pumpKernel.pdf');
%[PPdata6pump80, PPdata6pump110, PPdata6ratio80over110, PPdata6ratio110over80] = pumpKernel(PPdata6.name,PPdata6.TotalPump,'#7E2F8E','PPdata6-pumpKernel.pdf');
%[PPdata7pump80, PPdata7pump110, PPdata7ratio80over110, PPdata7ratio110over80] = pumpKernel(PPdata7.name,PPdata7.TotalPump,'#77AC30','PPdata7-pumpKernel.pdf');
%[PPdata8pump80, PPdata8pump110, PPdata8ratio80over110, PPdata8ratio110over80] = pumpKernel(PPdata8.name,PPdata8.TotalPump,'#D95319','PPdata8-pumpKernel.pdf');

%add/remove % sign for the correct number of PPdata to analyze

tableKernelRatio(1:5,1) = {""; "% of pump between 70 and 90 ms"; "% of pump between 100 and 120 ms"; "Ratio 80 ms over 110 ms"; "Ratio 110 ms over 80 ms"};
tableKernelRatio(1:5,2) = {PPdata1.name, PPdata1pump80, PPdata1pump110, PPdata1ratio80over110, PPdata1ratio110over80};
tableKernelRatio(1:5,3) = {PPdata2.name, PPdata2pump80, PPdata2pump110, PPdata2ratio80over110, PPdata2ratio110over80};
tableKernelRatio(1:5,4) = {PPdata3.name, PPdata3pump80, PPdata3pump110, PPdata3ratio80over110, PPdata3ratio110over80};
%tableKernelRatio(1:5,5) = {PPdata4.name, PPdata4pump80, PPdata4pump110, PPdata4ratio80over110, PPdata4ratio110over80};
%tableKernelRatio(1:5,6) = {PPdata5.name, PPdata5pump80, PPdata5pump110, PPdata5ratio80over110, PPdata5ratio110over80};
%tableKernelRatio(1:5,7) = {PPdata6.name, PPdata6pump80, PPdata6pump110, PPdata6ratio80over110, PPdata6ratio110over80};
%tableKernelRatio(1:5,8) = {PPdata7.name, PPdata7pump80, PPdata7pump110, PPdata7ratio80over110, PPdata7ratio110over80};
%tableKernelRatio(1:5,9) = {PPdata8.name, PPdata8pump80, PPdata8pump110, PPdata8ratio80over110, PPdata8ratio110over80};

writecell(tableKernelRatio,"PumpRatio.csv");

%Function for probability density histogram (pump duration)

function [pump80, pump110,ratio80over110, ratio110over80] = pumpKernel(legendPPdata,dataTotalPump,color,name)
    length = 0:1:400;
    kernelData = fitdist(dataTotalPump,"Kernel");
    kernelpdf = pdf(kernelData,length);
    bandwidthValue = "Bandwidth = " + kernelData.BandWidth;
    area(kernelpdf,"FaceColor",color);
    hold on
    axis ([0 300 0 0.020]);
    xlabel("Pump duration (ms)",'FontSize',30);
    ylabel("Probability density",'FontSize',28);
    title('Probability density function of pump duration');
    set(gca,'box','off','FontSize',20);
    legend(legendPPdata,"Location","northeast");
    text(154,0.033,bandwidthValue,'FontSize', 12);
    saveas(gcf,name);
    hold off
    pump80 = sum(kernelpdf([70:1:90]));
    pump110 = sum(kernelpdf([100:1:120]));
    ratio80over110 = pump80 / pump110;
    ratio110over80 = pump110 / pump80;
    plot(ecdf(dataTotalPump),"Color",color,"LineWidth",2);
    hold on
    axis([0 250 0 1]);
    xlabel("Pump duration (ms)",'FontSize',30);
    ylabel("Probability density",'FontSize',28);
    title('Cumulative density function of pump duration');
    saveas(gcf,"CDF_" + name);
    hold off
end