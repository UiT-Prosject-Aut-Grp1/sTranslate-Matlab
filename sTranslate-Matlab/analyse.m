close all;
clear all;

% Read files and add to array
logging{1} = csvread('Logg_FSharp_direct.csv');
logging{2} = csvread('logCSharpWithCache.csv');
logging{3} = csvread('logFSharpCache.csv');
logging{4} = csvread('logFSharpDirectNoCache.csv');
logging{5} = csvread('logFSharpDirectWithCache.csv');
logging{6} = csvread('logFSharpNoCache.csv');

% Set names
name{1} = 'C# no cache';
name{2} = 'C# width cache';
name{3} = 'F# cache';
name{4} = 'F# Direct no cache';
name{5} = 'F# Direct width cache';
name{6} = 'F# No Cache';

% Set names
color{1} = [1 0 0];
color{2} = [0 1 0];
color{3} = [0 0 1];
color{4} = [1 1 0];
color{5} = [0 1 1];
color{6} = [1 0 1];

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
