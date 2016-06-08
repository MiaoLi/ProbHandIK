function test()

data=load('../data/Bhand/BHandData.mat');
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
    x=DataTest(i,5:10)';
    for j=1:nbStates       
        ts(j) = gaussPDF(x, Mu(5:10,j), Sigma(5:10,5:10,j));
        ds(j)=(x-Mu(5:10,j))'*inv(Sigma(5:10,5:10,j)+realmin)*(x-Mu(5:10,j));
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
[y, Sigma_y] = GMR(Priors, Mu, Sigma, DataTestClose(:,[5:10])', [5:10], [1:4]);
BhandJointPre=y';
BhandJointPre = BhandJointPre.*repmat(inputscale(1:4),size(BhandJointPre,1),1)+repmat(inputmean(1:4),size(BhandJointPre,1),1);
BhandJointReal = DataOriginal(:,1:4);

dlmwrite('BhandJointReal.txt',BhandJointReal,'-append','delimiter','\t');
dlmwrite('BhandJointpPre.txt',BhandJointPre,'-append','delimiter','\t');

err = BhandJointReal-BhandJointPre
% MSE = sqrt(sum(err.* err)/size(err,1))

MAE =sum(abs(err),1)/size(err,1)
MAEVar= std(abs(err))
end

