function config = tisisoReport(config)
% tisisoReport REPORTING of the expLanes experiment timbralSimilaritySol
%    config = tisisoInitReport(config)
%       config : expLanes configuration state

% Copyright: Mathieu Lagrange
% Date: 09-Jan-2017

if nargin==0, timbralSimilaritySol('report', 'r'); return; end

% scat
mask = {3 [1 2 3] 1 1};

% mel and mfcc
% mask = {};
% 
% for k=1:3
%     mask{6} = k;
%     config = expExpose(config, 't', 'step', 3, 'mask', mask, 'percent', 0, 'precision', 4);
% end

% scattering design
config = expExpose(config, 'p', 'expand', 'sct', 'step', 3, 'mask', {[1 2] [1 2 3] 1 1 1 3}, 'percent', 0, 'precision', 4, 'obs', 1);