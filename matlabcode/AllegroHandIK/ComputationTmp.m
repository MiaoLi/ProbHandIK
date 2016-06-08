function ComputationTmp()
Ahand=[ 0.2075    0.3682    0.4240    0.3786    0.2002    0.3684    0.4302    0.4018    0.2259    0.2504    0.3244    0.3334;
        0.2065    0.3557    0.4004    0.3875    0.1999    0.3754    0.4090    0.3879    0.2315    0.2628    0.3062    0.3273;
        0.2011    0.3603    0.4005    0.3374    0.1902    0.3672    0.4071    0.3578    0.2094    0.2420    0.3222    0.3461;
        0.2082    0.3589    0.3873    0.3746    0.2021    0.3720    0.3831    0.3539    0.2180    0.2496    0.3308    0.3370;
        0.1931    0.3522    0.4047    0.3540    0.1850    0.3607    0.4094    0.3813    0.2263    0.2542    0.3322    0.3288];
bar(mean(Ahand),'FaceColor',[0 0.392157 0]); hold on;
errorbar(mean(Ahand),std(Ahand),'LineStyle','None','Color','r','LineWidth',2);hold on;
xlabel('Joint','FontSize',16);
ylabel('MAE(rad)','FontSize',16);

end

