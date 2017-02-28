function [data, judgments] = handleJudgments(config, data, type)

if ~exist('type', 'var'), type = 'multiple'; end

if length(data.mode)<length(data.file), data.file(end) = []; end
idx = [];
gt = [];
mgt = [];
egt = [];
d = load([config.codePath 'ticelJudgments.mat']);
for k=1:length(d.names)
    oct = strfind(data.file, d.names{k});
    oct = find(~cellfun(@isempty, oct));
    idx = [idx oct];
    gt = [gt repmat(d.ci(:, k), 1, length(oct))];
    mgt = [mgt repmat(d.medoid(k), 1, length(oct))];
    egt = [egt repmat(d.ensemble(k), 1, length(oct))];
end
[idx, ia] = unique(idx);
switch type
    case 'multiple'
        judgments = gt(:, ia); 
   case 'ensemble'
        judgments = egt(:, ia); 
    otherwise
        judgments = mgt(:, ia);
end
data = filterData(data, idx);

% FIXME the issue is that we can have redondancy in the selection