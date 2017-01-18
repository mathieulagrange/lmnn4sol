function [config, store, obs] = tisiso2project(config, setting, data)                      
% tisiso2project PROJECT step of the expLanes experiment timbralSimilaritySol              
%    [config, store, obs] = tisiso2project(config, setting, data)                          
%      - config : expLanes configuration state                                             
%      - setting   : set of factors to be evaluated                                        
%      - data   : processing data stored during the previous step                          
%      -- store  : processing data to be saved for the other steps                         
%      -- obs    : observations to be saved for analysis                                   
                                                                                           
% Copyright: Mathieu Lagrange                                                              
% Date: 09-Jan-2017                                                                        
                                                                                           
% Set behavior for debug mode                                                              
if nargin==0, timbralSimilaritySol('do', 2, 'mask', {2 1 2 1 0 3 2 0 0 2 1}); return; else store=[]; obs=[]; end

rng(0);

data = getFeatures(data, setting, config.step.id);

[~, ~, gt] = unique(data.(setting.reference));

switch setting.projection   
    case 'lmnn'
         store.projection = lmnnCG(data.features', gt', setting.neighbors, 'quiet', 1);
end