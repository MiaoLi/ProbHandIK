function BhandIKSolve()
%% This function is used to find the finger joint angle for Bhand;
load DataTest;
load inputmean;
load inputscale;
load StructGMM;
Priors = StructGMM.Priors;
Mu = StructGMM.Mu;
Sigma=StructGMM.Sigma;
nbStates=size(Mu,2);
objname = 'teacan';
FeasibleGrasp =[];
for i = 1:100
    fname = ['../AMPL/new_results/',objname,'/sol_cylinder_p',num2str(i),'.txt'];
    [bopt,solve_time,points,np] = readResult(fname);   
    if(bopt)
        idx=[1,2,3;1,3,2;2,1,3;2,3,1;3,1,2;3,2,1;];
        [Gcode]= encoder(points,np,idx);
        [BhandJointAll,distAll,idAll] = CompJoint(Gcode, StructGMM, inputmean, inputscale);
        for j=1:size(BhandJointAll)
            if(norm(BhandJointAll(j,:))>0 &&BhandJointAll(j,1)>-0.1 &&BhandJointAll(j,2)>-0.1&&...
                BhandJointAll(j,3)>-0.1&&BhandJointAll(j,4)>-0.1)
                FeasibleGrasp =[FeasibleGrasp;BhandJointAll(j,:), ...
                    points(idx(j,1),:),points(idx(j,2),:),points(idx(j,3),:),...
                    np(idx(j,1),:),np(idx(j,2),:),np(idx(j,3),:),i,j]; % save the feasible grasp and its index
            end
        end
    end
    
end
size(FeasibleGrasp)
save('FeasibleGrasp.mat','FeasibleGrasp');
dlmwrite(['FeasibleGrasp_',objname,'_Bhand','.txt'],FeasibleGrasp,'-append','delimiter','\t');
end

    function [Gcode]= encoder(points,np,idx)
        DataCenter = mean(points);
        Gcode = zeros(size(idx,1),6);
        for i=1:size(idx,1)
            Gcode(i,1)= sqrt(sum((points(idx(i,1),:)-DataCenter).^2,2));
            Gcode(i,2)= sqrt(sum((points(idx(i,2),:)-DataCenter).^2,2));
            Gcode(i,3)= sqrt(sum((points(idx(i,3),:)-DataCenter).^2,2));
            
            Gcode(i,4)=sum(np(idx(i,1),:).*np(idx(i,2),:),2);  %% Note that we should change np to -np, but the encoder valuer is the same;
            Gcode(i,5)=sum(np(idx(i,1),:).*np(idx(i,3),:),2);
            Gcode(i,6)=sum(np(idx(i,2),:).*np(idx(i,3),:),2);
        end
    end

    function [BhandJointAll,distAll,idAll] = CompJoint(Gcode, StructGMM, inputmean, inputscale)
        Gcode = (Gcode-repmat(inputmean(:,5:10),size(Gcode,1),1))./repmat(inputscale(:,5:10),size(Gcode,1),1);
        BhandJointAll = zeros(size(Gcode,1),4);
        distAll = zeros(size(Gcode,1),1);
        idAll = zeros(size(Gcode,1),1);
        
        Priors = StructGMM.Priors;
        Mu = StructGMM.Mu;
        Sigma=StructGMM.Sigma;
        nbStates=size(Mu,2);
        
        for i=1:nbStates
            x=Mu(5:10,i)+1*sqrt(diag(Sigma(5:10,5:10,i)));
            ts(i) = gaussPDF(x, Mu(5:10,i), Sigma(5:10,5:10,i));
        end
        ts(ts<realmin)=realmin;
        ts=log(ts);
        
        for i= 1:size(Gcode,1)
            x = Gcode(i,:)';
            
            for j=1:nbStates
%                ds(j)=(x-Mu(5:10,j))'*inv(Sigma(5:10,5:10,j)+realmin)*(x-Mu(5:10,j));
                ds(j) = gaussPDF(x, Mu(5:10,i), Sigma(5:10,5:10,i));
            end
            
            ds(ds<realmin)=realmin;
            ds=log(ds);
            [dist,id]=min(ds);
            if(sum(ds>ts)>0)
                [y, Sigma_y] = GMR(Priors, Mu, Sigma,x, [5:10], [1:4]);
                BhandJointPre=y';
                BhandJointPre = BhandJointPre.*repmat(inputscale(1:4),size(BhandJointPre,1),1)+repmat(inputmean(1:4),size(BhandJointPre,1),1);
                BhandJoint = BhandJointPre;
            else
                BhandJoint = zeros(4,1);
            end
            BhandJointAll(i,:) = BhandJoint;
            distAll(i) = dist;
            idAll(i) = id;
        end
    end

