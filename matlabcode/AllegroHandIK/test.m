function test()

data=load('../data/AllegroHand/AllegroHandData.mat');
data=data.data;
data = data(400000:end,:); % The original data;
load DataTest;
load inputmean;
load inputscale;
load StructGMM;
Priors = StructGMM.Priors;
Mu = StructGMM.Mu;
Sigma=StructGMM.Sigma;
nbStates=size(Mu,2);
%%
DataTestClose=[];
DataOriginal=[];

for i = 4001:5000
    x=DataTest(i,13:18)';
    for j=1:nbStates       
        ts(j) = gaussPDF(x, Mu(13:18,j), Sigma(13:18,13:18,j));
        ds(j)=(x-Mu(13:18,j))'*inv(Sigma(13:18,13:18,j)+realmin)*(x-Mu(13:18,j));
    end
    ts(ts<realmin)=realmin;
    ts=log(ts);
    ds(ds<realmin)=realmin;
    if(min(ds)<4.5)
        DataTestClose = [DataTestClose;DataTest(i,:)];
        DataOriginal = [DataOriginal;data(i,:)];       
    end
end
size(DataTestClose)
[y, Sigma_y] = GMR(Priors, Mu, Sigma, DataTestClose(:,[13:18])', [13:18], [1:12]);
AhandJointPre=y';
AhandJointPre = AhandJointPre.*repmat(inputscale(1:12),size(AhandJointPre,1),1)+repmat(inputmean(1:12),size(AhandJointPre,1),1);
AhandJointReal = DataOriginal(:,1:12);

dlmwrite('AhandJointReal.txt',AhandJointReal,'-append','delimiter','\t');
dlmwrite('AhandJointpPre.txt',AhandJointPre,'-append','delimiter','\t');

err = AhandJointReal-AhandJointPre;
% MSE = sqrt(sum(err.* err)/size(err,1))

MAE =sum(abs(err),1)/size(err,1)
MAEVar= std(abs(err))
end

