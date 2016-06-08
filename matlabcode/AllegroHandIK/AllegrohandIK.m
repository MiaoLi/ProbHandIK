function AllegrohandIK()
%% This function is used to train the Allegrohand IK

copy('../pythoncode/AllegroHandData.txt','.');
filename= 'AllegroHandData.txt';
DataPreprocess(filename);

load DataTrain;
load DataValid;
load DataTest;
DataTrain = DataTrain(randsample(size(DataTrain,1),200000),:);
cnt = 1;
for nbStates = 46   % Run Cross-Validation to choose the best nbStates;
    [Priors0, Mu0, Sigma0] = EM_init_kmeans(DataTrain', nbStates);
    [Priors, Mu, Sigma, Pix] = EM(DataTrain', Priors0, Mu0, Sigma0);
    
    Pxi=[];
    for i=1:nbStates
        Pxi(:,i) = Priors(i).*gaussPDF(DataTrain', Mu(:,i), Sigma(:,:,i));
    end
    px=sum(Pxi,2);    
    px(px<realmin) = realmin;    
    BICtrain(cnt)=-2*sum(log(px))+nbStates*log(size(DataTrain,1))
    cnt = cnt +1;
    display(['   ' 'nbStates: ' int2str(nbStates) , ' finisized']);
end
    save('BICtrain.mat','BICtrain');
    StructGMM = struct('Priors', Priors,'Mu',Mu, 'Sigma',Sigma);
    save('StructGMM.mat','StructGMM');

end

