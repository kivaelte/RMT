function SE = GetSelectElectrode(EEG, Spectrum)

% Select the relevant electrodes
%
% Usage: SE = GetSelectElectrode(EEG, Spectrum)
%
% Input(s):
% EEG = EEG struct
% Spectrum = range of frequency to inspect, e.g., [8 12] for alpha
%
% Output:
% SE = selected electrode
%
% Author: K.V.E. Temme
%
% Thoughts for later: slice EEG dataset for relevant electrodes

numElectrodes = 64;
alphaPower = zeros(1, numElectrodes);

for i = 1:numElectrodes
    alphaPower(i) = 100 * (bandpower(EEG.data(i,:), EEG.srate, Spectrum) / ...
        bandpower(EEG.data(i,:), EEG.srate, [0 44]));
end

% Plot the top view of the head with electrode locations
figure;
topoplot(alphaPower, EEG.chanlocs, 'maplimits', [min(alphaPower), max(alphaPower)], 'colormap', jet);

% Set the color bar and title
colorbar;
title('Alpha Power Distribution on the Head');

% Select the electrode with the highest alpha power
[~, maxAlphaElectrode] = max(alphaPower);
selectedElectrode = EEG.chanlocs(maxAlphaElectrode).labels;

% Display the selected electrode
text(EEG.chanlocs(maxAlphaElectrode).X, EEG.chanlocs(maxAlphaElectrode).Y, 'X', 'Color', 'red');
text(EEG.chanlocs(maxAlphaElectrode).X, EEG.chanlocs(maxAlphaElectrode).Y, selectedElectrode, 'Color', 'red');

SE = selectedElectrode;

end
