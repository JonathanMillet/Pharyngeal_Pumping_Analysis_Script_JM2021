classdef PPdataClass < handle
    properties
        name
        freq
        mufreq
        sigmafreq
        zscore
        outlier
        freqPlot
        freqSorted
        freqCDF
        stattest
        ksPvalue
        ksKvalue
        meanDur
        IPIDur
        medRtoE
        pumpModel
        IPIModel
        TotalPump
        TotalIPI
    end
    methods
        function loadPPdata(obj,file1,file2,file3)
            if exist(file1,'file')~=0
                [~,~,day1]=xlsread(file1);
                [~,~,day2]=xlsread(file2);
                [~,~,day3]=xlsread(file3);
                file=cat(1,day1(2:end,:),day2(2:end,:),day3(2:end,:));
                obj.name=cell2mat(file(1,7));
                obj.freq=cell2mat(file(:,19));
                obj.mufreq=mean(obj.freq);
                obj.sigmafreq=std(obj.freq);
                obj.outlier=isoutlier(obj.freq,'mean');
                obj.freqPlot=rmoutliers(obj.freq,'mean');
                obj.zscore=(obj.freq-obj.mufreq)/obj.sigmafreq;
                cdf=normcdf(obj.freqPlot,mean(obj.freqPlot),std(obj.freqPlot));
                sorting=sortrows([obj.freqPlot cdf]);
                obj.freqSorted=sorting(:,1);
                obj.freqCDF=sorting(:,2);
                [test,obj.ksPvalue,obj.ksKvalue]=kstest((obj.freqPlot-obj.mufreq)/obj.sigmafreq);
                if test==1
                    obj.stattest="Normal";
                else
                    obj.stattest="Not normal";
                end
                TrueRecord=0;sumMeanDur=0;sumMeanIPI=0;sumMedRtoE=0;
                for n=1:size(file)
                    if cell2mat(file(n,17))~=0
                        sumMeanDur=sumMeanDur+(cell2mat(file(n,20))*cell2mat(file(n,17)));
                        sumMeanIPI=sumMeanIPI+(cell2mat(file(n,26))*cell2mat(file(n,17)));
                        sumMedRtoE=sumMedRtoE+(cell2mat(file(n,25))*cell2mat(file(n,17)));
                        TrueRecord=TrueRecord+cell2mat(file(n,17));
                    end
                end
                obj.meanDur=cell2mat(file(:,20));
                obj.IPIDur=cell2mat(file(:,26));
                obj.medRtoE=sumMedRtoE/TrueRecord;
                obj.pumpModel=zeros(1,2200);
                obj.IPIModel=zeros(1,8800);
                x=20;step=200-x;e=1/x;r=-obj.medRtoE/x;pumpDur=round((sumMeanDur/TrueRecord)*10);
                for n=1:x
                   obj.pumpModel(step)=e;
                   obj.pumpModel(step+x)=1-e;
                   obj.pumpModel(step+pumpDur)=r;
                   obj.pumpModel(step+pumpDur+x)=-obj.medRtoE-r;
                   step=step+1;e=e+(1/x);r=r-obj.medRtoE/x;
                end
                y=80;step2=800-y;e2=1/y;r2=-obj.medRtoE/y;meanIPI=round((sumMeanIPI/TrueRecord)*10);
                for n=1:y
                   obj.IPIModel(step2)=r2;
                   obj.IPIModel(step2+y)=-obj.medRtoE-r2;
                   obj.IPIModel(step2+meanIPI)=e2;
                   obj.IPIModel(step2+meanIPI+y)=1-e2;
                   step2=step2+1;e2=e2+(1/y);r2=r2-obj.medRtoE/y;
                end
            [~,~,spike1]=xlsread(file1,"Spike Times");
            [~,~,spike2]=xlsread(file2,"Spike Times");
            [~,~,spike3]=xlsread(file3,"Spike Times");
            spike1=cell2mat(spike1(3:end,:));
            spike2=cell2mat(spike2(3:end,:));
            spike3=cell2mat(spike3(3:end,:));
            m=2;
            for i=1:30
                for n=1:size(spike1)
                    obj.TotalPump(n,i)=spike1(n,m)-spike1(n,m-1);
                end
                for n=1:(size(spike1)-1)
                    obj.TotalIPI(n,i)=spike1(n+1,m-1)-spike1(n,m);
                end
                for n=1:size(spike2)
                    obj.TotalPump(n,30+i)=spike2(n,m)-spike2(n,m-1);
                end
                for n=1:(size(spike2)-1)
                    obj.TotalIPI(n,30+i)=spike2(n+1,m-1)-spike2(n,m);
                end
                for n=1:size(spike3)
                    obj.TotalPump(n,60+i)=spike3(n,m)-spike3(n,m-1);
                end
                for n=1:(size(spike3)-1)
                    obj.TotalIPI(n,60+i)=spike3(n+1,m-1)-spike3(n,m);
                end
                m=m+2;
            end
            obj.TotalPump(isnan(obj.TotalPump))=0;
            obj.TotalPump(isoutlier(obj.TotalPump))=0;
            obj.TotalPump=nonzeros(obj.TotalPump);
            obj.TotalIPI(isnan(obj.TotalIPI))=0;
            obj.TotalIPI(isoutlier(obj.TotalIPI))=0;
            obj.TotalIPI=nonzeros(obj.TotalIPI);
            end
        end
        function tableoutput(obj,namefile)
            tableExport=nan(90,8);j=0;
            line1to3(1:3,:)=["Name","Mean Frequency","Standard Deviation","Sample count","Sample used","Distribution","p-value","k-value";obj.name,obj.mufreq,obj.sigmafreq,numel(obj.freq),numel(obj.freqPlot),obj.stattest,obj.ksPvalue,obj.ksKvalue;"Frequency (Hz)","z-score","Outlier state","Frequency used (Hz)","Frequency sorted (Hz)","Frequency CDF","",""];
            plop=cat(1,line1to3,tableExport);
            for i=1:numel(obj.freq)
                plop(i+3,1:2)=[obj.freq(i),obj.zscore(i)];
                if obj.outlier(i)==0
                    plop(i+3,3)="False";
                else
                    plop(i+3,3)="True";
                end
            end
            for i=1:numel(obj.freq)
                if obj.outlier(i)==0
                    plop(i+3,4:6)=[obj.freqPlot(i-j),obj.freqSorted(i-j),obj.freqCDF(i-j)];
                else
                    j=j+1;
                end
            end
            writematrix(plop,namefile)
        end
        function cleanmeanDur(obj)
            obj.meanDur(isnan(obj.meanDur))=0;
            obj.meanDur(isoutlier(obj.meanDur))=0;
            obj.meanDur=nonzeros(obj.meanDur);
        end
        function cleanIPIdur(obj)
            obj.IPIDur(isnan(obj.IPIDur))=0;
            obj.IPIDur(isoutlier(obj.IPIDur))=0;
            obj.IPIDur=nonzeros(obj.IPIDur);
        end
    end
end