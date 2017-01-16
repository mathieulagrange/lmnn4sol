function config = tisisoReport(config)
% tisisoReport REPORTING of the expLanes experiment timbralSimilaritySol
%    config = tisisoInitReport(config)
%       config : expLanes configuration state

% Copyright: Mathieu Lagrange
% Date: 09-Jan-2017

if nargin==0, timbralSimilaritySol('report', 'r'); return; end

mask = {0 1 0 0 1 1 0};

for k=1:3
    mask{end} = k;
    config = expExpose(config, 't', 'step', 3, 'mask', mask, 'obs', [2 1], 'percent', 0);
end