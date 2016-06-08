function DataPreprocess(filename)
%% This file is used to preprocess the data
% if exist('../data/Bhand/BHandData.mat','file')
%    data=load('../data/Bhand/BHandData.mat');
%    data=data.data;
%    display('start to preprocess the data');
% else
%     data = importdata('../data/Bhand/BHandData.txt');
%     save('../data/Bhand/BHandData.mat','data');
% end
    data = importdata(filename);
    save('BHandData.mat','data');
%%  
    % new data encoder:
    DataNew = zeros(size(data,1),10);
    DataNew(:,1:4)= data(:,1:4);
    DataCenter = (data(:,5:7)+data(:,8:10)+data(:,11:13))/3;
    DataNew(:,5)= sqrt(sum((data(:,5:7)-DataCenter).^2,2));
    DataNew(:,6)= sqrt(sum((data(:,8:10)-DataCenter).^2,2));
    DataNew(:,7)= sqrt(sum((data(:,11:13)-DataCenter).^2,2));
    DataNew(:,8)=sum(data(:,14:16).*data(:,17:19),2);
    DataNew(:,9)=sum(data(:,14:16).*data(:,20:22),2);
    DataNew(:,10)=sum(data(:,17:19).*data(:,20:22),2);
    DataNew = DataNew.*(ones(size(DataNew))+0.05*rand(size(DataNew)));
    
    DataTrain = DataNew(1:200000,:);
    [DataTrain,inputmean,inputscale] = CenterAndNormalize(DataTrain);
    save('inputmean.mat','inputmean');
    save('inputscale.mat','inputscale');
    save('DataTrain.mat','DataTrain');
    DataValid = DataNew(200000:400000,:);
    DataValid = (DataValid-repmat(inputmean, size(DataValid,1),1))./repmat(inputscale,size(DataValid,1),1);
    save('DataValid.mat','DataValid');
    DataTest = DataNew(400000:end,:);
    DataTest = (DataTest-repmat(inputmean, size(DataTest,1),1))./repmat(inputscale,size(DataTest,1),1);
    save('DataTest.mat','DataTest');
end

