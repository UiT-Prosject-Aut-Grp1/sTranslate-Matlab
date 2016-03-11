close all;
clear all;

% Import logging Files
cs = csvread('Logg_CSharp.csv');
fs = csvread('Logg_FSharp.csv');
fsd = csvread('Logg_FSharp_direct.csv');

% Read files and add to array
logging{1} = cs;
logging{2} = fs;
logging{3} = fsd;

% Set names
name{1} = 'C#';
name{2} = 'F#';
name{3} = 'F# direct';

% Set names
color{1} = [1 0 0];
color{2} = [0 1 0];
color{3} = [0 0 1];

% Name graphics window
figure('name','Histogram');
for logNumber = 1:length(logging)
    
    % Convert to ms
    logging{logNumber} = logging{logNumber}*1000;
    
    % Remove first element
    logging{logNumber}(1) = [];
    
    % Average
    average(logNumber) = mean(logging{logNumber});
    
    % Remover outliers
    i = 1;
    while i <= length(logging{logNumber})
        if logging{logNumber}(i) >  average(logNumber)*1.25
           logging{logNumber}(i) = [];
        elseif logging{logNumber}(i) <  average(logNumber)*0.75
           logging{logNumber}(i) = [];
        else
            i = i+1;
        end
    end
    
    % Make histogram
    set(findobj(gca,'Type','patch'),'FaceColor',color{logNumber},'EdgeColor','w');
    hist(logging{logNumber})
    hold on;
end
title('Histogram')
set(gca,'XScale','log')


% Average chart
hold off;
figure('name','Average');
bar(average);
set(gca,'YScale','log')
