function SE = GetSelectElectrode(EEG,Spectrum)  

%Select the relevant electrodes
%
% Usage: SE = GetSelectElectrode(EEG, Spectrum)
%
% Input(s): 
% EEG = EEG struct
% Spectrum = range of frequency to inspect, e.g. [3 8] for theta
%
% Output:
% SE = selected electrode
% 
% Author: K.V.E. Temme
%
% thoughts for later: slice EEG dataset for relevant electrodes

for i=1:64
    relpower(i) = 100*(bandpower(EEG.data(i,:),100,Spectrum)/ ...
        bandpower(EEG.data(i,:),100,[0 44]));
end


[maxrelpower,SE] = max(relpower)