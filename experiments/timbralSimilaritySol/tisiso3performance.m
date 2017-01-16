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
if nargin==0, timbralSimilaritySol('do', 3, 'mask', {3 0 1 3 1 3 0}); return; else store=[]; obs=[]; end

rng(0);

features = getFeatures(data1);

p = squareform(pdist(features));

[~, ~, gt] = unique(data1.(setting.reference));

o = rankingMetrics(p, gt);
obs.p = o.precisionAt5;
obs.map = o.meanAveragePrecision;