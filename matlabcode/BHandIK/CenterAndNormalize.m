function [dataout, inputmean, inputscale] = CenterAndNormalize(datain)
inputmean = mean(datain,1);
dataout = (datain - repmat(inputmean, size(datain,1),1));
inputscale = max(abs(dataout),[],1);
dataout = dataout./repmat(inputscale,size(datain,1),1);
end