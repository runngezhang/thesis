%% Speech separation and recognition from an HMM Trained on TIMIT copurs by HTK
% 
%   Plotting HTK training intermediate and final test results 
%
% University of Patras - Anastasia Grigoropoulou 2016

clear;
clc;

% Set up directories
HOME = '../';
RESULTSDIR = strcat(HOME,'logs/');
file_handle = 'log.results_';


%% Plotting until end of initial training
file_exts = {'mono','mono_sp','mono_al','tied'};

for i=1:size(file_exts,2)
    filename = strcat(file_handle,file_exts{i});
    buffer = fileread(strcat(RESULTSDIR, filename));

    results = regexp(buffer,'(?:\%Correct*\=)(?<h>[0-9.]*)','tokens');
    sent = str2double([results{:}]);
    results = regexp(buffer,'(?:\%Corr*\=)(?<h>[0-9.]*)','tokens');
    word = str2double([results{:}]);

    phn = word(1:3:size(results,2));
    wrd_net = word(2:3:size(results,2));
    wrd_lm = word(3:3:size(results,2));
    sent_net = sent(2:3:size(results,2));
    sent_lm = sent(3:3:size(results,2));

    DATA = [phn; wrd_net; wrd_lm; sent_net; sent_lm]';
    
    % Be careful, it will overwrite current figure
%     results_figure_20(DATA, strcat('Figures/',filename,'.fig'));
end

%% Plotting subsequent mixing
filename = strcat(file_handle,'mixed');
buffer = fileread(strcat(RESULTSDIR,filename));

results = regexp(buffer,'(?:\%Correct*\=)(?<h>[0-9.]*)','tokens');
sent = str2double([results{:}]);
results = regexp(buffer,'(?:\%Corr*\=)(?<h>[0-9.]*)','tokens');
word = str2double([results{:}]);

phn = word(1:3:size(results,2));
wrd_net = word(2:3:size(results,2));
wrd_lm = word(3:3:size(results,2));
sent_net = sent(2:3:size(results,2));
sent_lm = sent(3:3:size(results,2));

DATA = [phn; wrd_net; wrd_lm; sent_net; sent_lm]';

    % Be careful, it will overwrite current figure
% results_figure_4(DATA, strcat('Figures/',filename,'.fig'));
%% Plotting tuning of parameters
filename = strcat(file_handle,'tune');
buffer = fileread(strcat(RESULTSDIR,filename));

results = regexp(buffer,'(?:\%Correct*\=)(?<h>[0-9.]*)','tokens');
sent = str2double([results{:}]);
results = regexp(buffer,'(?:\%Corr*\=)(?<h>[0-9.]*)','tokens');
word = str2double([results{:}]);

phn = word(1:3:size(results,2));
wrd_net = word(2:3:size(results,2));
wrd_lm = word(3:3:size(results,2));
sent_net = sent(2:3:size(results,2));
sent_lm = sent(3:3:size(results,2));

DATA = [phn; wrd_net; wrd_lm; sent_net; sent_lm]';

    % Be careful, it will overwrite current figure
% results_figure_tune(DATA, strcat('Figures/',filename,'.fig'));

%% Plotting
filename = 'Outputs/log.results';
buffer = fileread(filename);

results = regexp(buffer,'(?:\%Corr*\=)(?<h>[0-9.]*)','tokens');
word = str2double([results{:}]);

sent1 = word(1:10)/word(1)*100;
sent2 = word(11:end)/word(11)*100;

% SNR = [0,   1, 2,  5, 10, 15, 20, 30 ,40, inf]
% ind = [1,   2, 3,  4,  5,  6,  7,  8,  9, 10]
% res = [inf, 0, 1, 10, 15,  2, 20, 30, 40, 5];
ind = [2 3 6 10 4 5 7 8 9 1];
sent1 = sent1(ind);
sent2 = sent2(ind);

DATA = [sent1; sent2]';
results_figure_matlab(DATA, 'Figures/results_matlab.fig');
