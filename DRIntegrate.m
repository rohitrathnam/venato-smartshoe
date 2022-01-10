function driSignal = DRIntegrate(signal, freq, beginData, endData)

% DRI Direct and reverse integration

%   D = DRI(SIGNAL, FREQ, BEGINDATA, ENDDATA), returns the integration of
%   SIGNAL with sampling rate of FREQ. 
%   BEGINDATA and ENDDATA are the values of integrated signals at initial 
%   and ending points.

%   INPUT(S):
%     signal    : input signal to be integrated
%     freq      : frequency of the input signal
%     beginData : initial value of integrated signal
%     endData   : last value of integrated signal
%     weightFunction : type of weight function to use. Value should be one
%                      of these: 'linear','invTan' and 'sigmoid'. Here the
%                      'invTan'is chosen.
%     invTanBeta     : if the WEIGHTFUNCTION is given as 'invTan', this
%                      parameter will set the beta constant in the
%                      equation. Default is 0.1.
%
%   OUTPUT(S):
%     D         : integrated signal

% Direct integration of the signal using Cavalieri-Simpons' method through the function SINTEGRATE
integrationType = 3; % Cavalieri-Simpsons --> type 3

% direct integration
di = sintegrate(signal,freq,integrationType,beginData);

% inverse integration with SINTEGRATE: 
% The integrating signal must have the last value of the original signal as its first sample, and so on
% -> mirroring of the signal
% The starting boundary condition becomes the final value changed in sign.
ri = sintegrate(flipud(signal),freq,integrationType, -endData); % integration 
% Return the ri signal to the original timeline and change the sign
ri = - flipud(ri);

%% Weighting function
% len = length of the integration interval
len = size(signal,1);
% parameter between 0 and 1 of the steepness of the sigmoid curve
invTanBeta = 0.4;
% s is a sigmoide function symmetrical over the integration interval ta-tb
t = (1:length(signal));
s = atan((2*t-len)/(2*invTanBeta*len));
% w is the weighting function which normalizes s between 0 and 1
w = (s-s(1))/(s(end)-s(1));
% if the integrating signal had more columns
width = size(signal,2);
if width>1
    w = repmat(w,1,width);
end

%%  weighted sum with respect to w
% dri(t) is the weighted sum with respect to w(t) of d(t) and r(t)
driSignal = ri.*w'+di.*(1-w)';

end