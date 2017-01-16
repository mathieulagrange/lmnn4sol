function [config, store, obs] = tisiso1features(config, setting, data)
% tisiso1features FEATURES step of the expLanes experiment timbralSimilaritySol
%    [config, store, obs] = tisiso1features(config, setting, data)
%      - config : expLanes configuration state
%      - setting   : set of factors to be evaluated
%      - data   : processing data stored during the previous step
%      -- store  : processing data to be saved for the other steps
%      -- obs    : observations to be saved for analysis

% Copyright: Mathieu Lagrange
% Date: 09-Jan-2017

% Set behavior for debug mode
if nargin==0, timbralSimilaritySol('do', 1, 'mask', {3 3}); return; else store=[]; obs=[]; end

% fid = fopen([config.inputPath 'fileList.txt']);
% fileList = textscan(fid, '%s/%s\n');
% fileList = fileList{1};
% fclose(fid);

fid = fopen([config.inputPath 'fileList.txt']);
fileList = fscanf(fid, '%s\n');
fclose(fid);
fileList = regexp(fileList, '.wav', 'split');
fileList(end)=[];

D = regexp(fileList, '/', 'split');
for k=1:length(D)-1,
    dk = D{k};
    instrument{k} = dk{1};
    mode{k} = [dk{1} '-' dk{2}];
    name{k} = dk{3};
end

si = regexp(instrument, '-', 'split');
for k=1:length(si),
    sik = si{k};
    family{k} = sik{1};
end

% length(unique(instrument))
% length(unique(mode))
% length(unique(family))

store.instrument = instrument;
store.mode = mode;
store.family = family;

scat_opt.M = 2;
scat_opt.oversampling = 4;
scat_opt.path_margin = 4;

% failed = 0;
parfor k=1:length(fileList)
    [a,sr] = audioread([config.inputPath fileList{k} '.wav']);
    cc = 0;
    switch setting.features
        case 'mel'
            [~, cc] = melfcc(a(:,1), sr);
        case 'mfcc'
            cc = melfcc(a(:,1), sr, 'numcep', 40);
        case 'scat'
            filt_opt = default_filter_options('audio', sr*setting.sct/1000);
            filt_opt.Q(1) = 12;
            Wop3 = wavelet_factory_1d(length(a), filt_opt, scat_opt);
            S = scat(a(:,1), Wop3);
            S = format_scat(S,'order_table');
            cc = [S{1+1}' S{1+2}']';
        case 'null'
            cc = rand(100);
    end
    cc = nanmean(cc');
    features(k, :) = cc;
%     if ~isfinite(cc), failed{end+1}=k; end
end

store.features = features;
% obs.failed = length(failed);
