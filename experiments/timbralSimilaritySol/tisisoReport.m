function config = tisisoReport(config)                                  
% tisisoReport REPORTING of the expLanes experiment timbralSimilaritySol
%    config = tisisoInitReport(config)                                  
%       config : expLanes configuration state                           
                                                                        
% Copyright: Mathieu Lagrange                                           
% Date: 09-Jan-2017                                                     
                                                                        
if nargin==0, timbralSimilaritySol('report', 'rhv'); return; end        
                                                                        
config = expExpose(config, 't');                                        
