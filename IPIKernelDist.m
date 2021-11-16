%Interpump kernel distribution
%add/remove % sign for the correct number of PPdata to analyze

pumpKernel(PPdata1.name,PPdata1.TotalIPI,'#000000','PPdata1-IPIKernel.pdf');
pumpKernel(PPdata2.name,PPdata2.TotalIPI,'#C82929','PPdata2-IPIKernel.pdf');
pumpKernel(PPdata3.name,PPdata3.TotalIPI,'#1C76BC','PPdata3-IPIKernel.pdf');
%pumpKernel(PPdata4.name,PPdata4.TotalIPI,'#F7941D','PPdata4-IPIKernel.pdf');
%pumpKernel(PPdata5.name,PPdata5.TotalIPI,'#2AB673','PPdata5-IPIKernel.pdf');
%pumpKernel(PPdata6.name,PPdata6.TotalIPI,'#7E2F8E','PPdata6-IPIKernel.pdf');
%pumpKernel(PPdata7.name,PPdata7.TotalIPI,'#77AC30','PPdata7-IPIKernel.pdf');
%pumpKernel(PPdata8.name,PPdata8.TotalIPI,'#D95319','PPdata8-IPIKernel.pdf');

%Function for probability density histogram (pump duration)

function pumpKernel(legendPPdata,dataTotalIPI,color,name)
    length = 0:1:400;
    kernelData = fitdist(dataTotalIPI,"Kernel");
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
end