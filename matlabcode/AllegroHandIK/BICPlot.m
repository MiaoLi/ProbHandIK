function BICPlot()
load BICtrain0.mat;
x=[1,6,11,16,21,26,31,36,41,46,51,55];
plot(x,BICtrain,'r*-', 'LineWidth',3);hold on;
plot(41,BICtrain(end-3),'s','MarkerSize',10,'LineWidth',3);hold on;
xlabel('Nb. of Gaussians','FontSize',16);
ylabel('BIC', 'FontSize',16)

end

