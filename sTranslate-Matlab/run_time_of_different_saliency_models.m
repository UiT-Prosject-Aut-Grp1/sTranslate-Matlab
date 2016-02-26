function [] = run_time_of_different_saliency_models()

%% loads AUC values corresponding to ordinary AUC metric
close all;


figure(1);

run_time = log([0.6043 0.0533 0.0726 20.1356 31.7515 15.703 23.3498 0.6516  10.2684]);

name = {'Itti','Hou','Spec','GBA','AIM', 'LG', 'Erdem', 'Fast GBA', 'AWS'};  
 
hb = bar(run_time,'FaceColor',[0.95 .85 .85],'EdgeColor',[1 0 0],'LineWidth',1.5);
axis([0.2 length(run_time)+0.7 -3 3.5]);
set(gca,'FontSize',14);
hold on;
set(gca,'XTick',[])
set(gca,'XColor','w')
for i=1:length(run_time)
    hb = text(i,-0.5,name{i},'Rotation',90,'FontWeight','bold');
    set(hb,'FontSize',15);
end

grid on;
ylabel('log of average run time (in sec.)');



% set(gca,'units','centimeters')
% set(gca,'Color','none');
% pos = get(gca,'Position');
% ti = get(gca,'TightInset');
% set(gcf, 'PaperUnits','centimeters');
% set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
% saveas(hb,'output.pdf');
% first use the same non-relative unit system for paper and screen (see
% below)
set(gcf,'PaperUnits','centimeters');

% now get all existing plots/subplots
a=get(gcf,'Children');
nfigs=length(a);

% bounds will contain lower-left and upper-right corners of plots plus one
% line to make sure single plots work
bounds=zeros(nfigs+1,4);
bounds(end,1:2)=inf;
bounds(end,3:4)=-inf;

% generate all coordinates of corners of graphs and store them in
% bounds as [lower-left-x lower-left-y upper-right-x upper-right-y] in
% the same unit system as paper (centimeters here)
for i=1:nfigs
    set(a(i),'Unit','centimeters');
    pos=get(a(i),'Position');
    inset=get(a(i),'TightInset');
    bounds(i,:)=[pos(1)-inset(1) pos(2)-inset(2) ...
        pos(1)+pos(3)+inset(3) pos(2)+pos(4)+inset(4)];
end

% compute the rectangular convex hull of all plots and store that info
% in mypos as [lower-left-x lower-left-y width height] in centimeters
auxmin=min(bounds(:,1:2));
auxmax=max(bounds(:,3:4));
mypos=[auxmin auxmax-auxmin];

% set the paper to the exact size of the on-screen figure using
% figure property PaperSize [width height]
set(gcf,'PaperSize',[mypos(3) mypos(4)]);

% ensure that paper position mode is in manual in order for the
% printer driver to honor the figure properties
set(gcf,'PaperPositionMode', 'manual');

% use the PaperPosition four-element vector [left, bottom, width, height]
% to control the location on printed page; place it using horizontal and
% vertical negative offsets equal to the lower-left coordinates of the
% rectangular convex hull of the plot, and increase the size of the figure
% accordingly

mypos(2) = 0.25*mypos(2);
set(gcf,'PaperPosition',[-mypos(1) -mypos(2) ...
    mypos(3)+mypos(1) mypos(4)+mypos(2)]);

% print stuff
print('-dpdf','run_times_sal.pdf');

end