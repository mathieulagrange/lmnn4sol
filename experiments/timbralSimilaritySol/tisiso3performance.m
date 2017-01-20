function [config, store, obs] = tisiso3performance(config, setting, data)
% tisiso3performance PERFORMANCE step of the expLanes experiment timbralSimilaritySol
%    [config, store, obs] = tisiso3performance(config, setting, data)
%      - config : expLanes configuration state
%      - setting   : set of factors to be evaluated
%      - data   : processing data stored during the previous step
%      -- store  : processing data to be saved for the other steps
%      -- obs    : observations to be saved for analysis

% Copyright: Mathieu Lagrange
% Date: 09-Jan-2017

% Set behavior for debug mode
if nargin==0, timbralSimilaritySol('do', 3, 'mask', {3 1 2 1 0 2 2 0 0 2 2 2 1}); return; else store=[]; obs=[]; end

rng(0);

data1 = expLoad(config, '', 1);

data1 = getFeatures(data1, setting, config.step.id);

switch setting.projection
    case 'lmnn'
        features = (data.projection*data1.features')';
    otherwise
        features = data1.features;
end
% features = features(:, 1);
[~, ~, gt] = unique(data1.(setting.reference));

n=knnsearch(features,features,'k',setting.neighbors+1);
n(:, 1) = [];

for k=1:size(features, 1)
    ind = gt(k)==gt;
    ind = ind(n(k, :));
    prec(k) = mean(ind);
end

obs.p = mean(prec);

% use for full set of metric (beware of memory comsumption)
% p = pdist(features);
% obs = rankingMetrics(p, gt, setting.neighbors, [], 1);
