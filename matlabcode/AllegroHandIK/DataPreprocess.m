function DataPreprocess(filename)
%% This file is used to preprocess the data
% if exist('../data/AllegroHand/AllegroHandData.mat','file')
%    data=load('../data/AllegroHand/AllegroHandData.mat');
%    data=data.data;
%    min(data,[],1)
%    display('start to preprocess the data');
% else
%     data = importdata('../data/AllegroHand/AllegroHandData.txt');
%     save('../data/AllegroHand/AllegroHandData.mat','data');
% end
    data = importdata(filename);
    save('AllegroHandData.mat','data');
%%  
    % new data encoder:
    DataNew = zeros(size(data,1),18);
    DataNew(:,1:12)= data(:,1:12);
    DataCenter = (data(:,13:15)+data(:,16:18)+data(:,19:21))/3;
    DataNew(:,13)= sqrt(sum((data(:,13:15)-DataCenter).^2,2));
    DataNew(:,14)= sqrt(sum((data(:,16:18)-DataCenter).^2,2));
    DataNew(:,15)= sqrt(sum((data(:,19:21)-DataCenter).^2,2));
    DataNew(:,16)=sum(data(:,22:24).*data(:,25:27),2);
    DataNew(:,17)=sum(data(:,22:24).*data(:,28:30),2);
    DataNew(:,18)=sum(data(:,25:27).*data(:,28:30),2);
    DataNew = DataNew.*(ones(size(DataNew))+0.01*rand(size(DataNew)));
    
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

