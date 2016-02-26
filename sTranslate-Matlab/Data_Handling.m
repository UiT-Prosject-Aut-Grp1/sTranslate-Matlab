% M = csvread('Logg.csv',';')
clc
close all

figure (1);
fileID = fopen('Logg_CSharp.csv');
C = textscan(fileID,'%f');
fclose(fileID);
rawdata_CSharp = C{1};
data_CSharp = rawdata_CSharp(2:1000);
mean_CSharp = trimmean(data_CSharp,10);
histogram(data_CSharp,'Normalization','pdf','FaceColor','r')

figure (2);
fileID = fopen('Logg_FSharp.csv');
C = textscan(fileID,'%f');
fclose(fileID);
rawdata_FSharp = C{1};
data_FSharp = rawdata_FSharp(2:1000);
mean_FSharp = trimmean(data_FSharp,10);
histogram(data_FSharp,'Normalization','pdf','FaceColor','b')

figure (3);
fileID = fopen('Logg_FSharp_direct.csv');
C = textscan(fileID,'%f');
fclose(fileID);
rawdata_FSharp_direct = C{1};
data_FSharp_direct = rawdata_FSharp_direct(2:100);
mean_FSharp_direct = trimmean(data_FSharp_direct,10);
histogram(data_FSharp_direct,'Normalization','pdf','FaceColor','g')

fprintf('Mean CSharp = %f, Mean FSharp = %f, Mean FSharp_Direct = %f',mean_CSharp, mean_FSharp, mean_FSharp_direct)
fprintf('\nInit CSharp = %f, Init FSharp = %f, Init FSharp_Direct = %f',rawdata_CSharp(1), rawdata_FSharp(1), rawdata_FSharp_direct(1))
% hold on
% histogram(data_FSharp_direct,'Normalization','pdf','FaceColor','g')

%tabulate(round(C{1}*1000)/1000)
%data = rawdata(2:1000);
% trim = trimmean(data,10);
% tabulate(round(data*1000)/1000);




%plot(h,(0:9))
%bar(M(1:end-1,1),M(1:end-1,3))
% d = c{1} 2:1000
% hist(C{1})
%disp(C{1})
% y = zeros(size(C{1}));
% for i = 1:length(C{1})
% y(i) = sum(C{1}==C{1}(i));
% end
% 
% plot(C{1},y)
% Load the sample data
% load Logg.csv
% % Find the maximum value in each column
% mx = max(Logg)
% % Calculate the mean of each column
% mu = mean(Logg)
% % Calculate the standard deviation of each column
% sigma = std(Logg)
% 
% % To get the row numbers where the maximum data values occur in each data column, 
% % specify a second output parameter indx to return the row index.
% 
% [mx,indx] = max(count)

% [n,p] = size(Logg);
% 
% % Define the x-values
% t = 0:0.00001:0.01-0.000001;
% fprintf('%d : %d',length(Logg),length(t))
% fanplot
% % Plot the data and annotate the graph
% plot(t,Logg)
% legend('Outcome')
% xlabel('Time')
% ylabel('Logg Count')
figure (4);
nbins=20;
series1 = [10,25,90,35,16, 8, 25, 55, 55];
series2 = [7,38,31,50,41,25,90,35,16];
[data_CSharp,centers] = hist(data_CSharp,nbins);
[data_FSharp] = hist(data_FSharp,centers);
DataSum=data_CSharp+data_FSharp;
width1 = 0.5;
bar(centers,DataSum,width1,'FaceColor',[0.2,0.2,0.5],....
                     'EdgeColor','none');
hold on
width2 = width1;
bar(centers,data_FSharp,width2,'FaceColor',[0,0.7,0.7],...
                     'EdgeColor',[0,0.7,0.7]);
hold off
legend('First Series','Second Series') % add legend