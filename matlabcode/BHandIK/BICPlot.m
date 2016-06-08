function BICPlot()
load BICtrain0.mat;
x=[1,6,11,16,21,26,31,36,41,46,51];
BICtrainnew = [BICtrain, -3.0521e+06, -3.1751e+06, -3.2781e+06];
plot(x,BICtrainnew,'r*-', 'LineWidth',3);hold on;
plot(36,BICtrain(end),'s','MarkerSize',10,'LineWidth',3);hold on;
xlabel('Nb. of Gaussians','FontSize',16);
ylabel('BIC', 'FontSize',16)

end

