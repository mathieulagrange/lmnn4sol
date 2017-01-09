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
if nargin==0, timbralSimilaritySol('do', 1, 'mask', {}); return; else store=[]; obs=[]; end
                                                                                           
