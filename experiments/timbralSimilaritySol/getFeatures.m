function features = getFeatures(data)

data = expLoad(config, '', 1);

data.features(end, :) = []; % TODO fix this

switch setting.corpus
    case 'test'
        
    case 'all'
        
    otherwise
        nbItems = length(data.mode);
        idx = randi(nbItems, ceil(nbItems*str2num(setting.corpus)/100), 1);
        data.features = data.features(idx, :);
        data.mode = data.mode(idx);
        data.instrument = data.instrument(idx);
        data.family = data.family(idx);
end

switch setting.projection
    case 'none'
        features = data.features;
end

switch setting.cut
    case 1
        switch setting.features
            case 'mfcc'
                features = features(:, 1:13);
            case 'scat'
                var=nanstd(features);
                var=var/(sum(var));
                [vars, I] = sort(var,2,'descend');
                features=features(:,I);
                sumvar=cumsum(vars);
                %                 features=features(:,sumvar<.83*sumvar(end));
                ix=find(sumvar>.83,1);
                features=features(:,1:ix);
        end
end

switch setting.normalize
    case 'standardize'
        features=bsxfun(@minus,features, mean(features));
        features=bsxfun(@rdivide,features, std(features));
    case 'median'
        eps=1e-3;
        medcc=repmat(eps*median(features,1),size(features, 1),1);
        features = features./medcc;
end

switch setting.features
    case 'scat'
        features=log1p(features);
end