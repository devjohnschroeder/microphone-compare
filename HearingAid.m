% Define parameters for the audio recording
Fs = 44100;  % Sampling frequency
nBits = 16;  % Bits per sample
nChannels = 1;  % Mono recording
recDuration = 5;  % Record for 5 seconds

% Create an audiorecorder object
recObj = audiorecorder(Fs, nBits, nChannels);

% Record audio for 5 seconds
disp('Start speaking.');
recordblocking(recObj, recDuration);
disp('End of Recording.');

% Store the recorded data in a variable
audioData = getaudiodata(recObj);

% Play back the recording
play(recObj);

% Save the audio data as a .wav file (optional)
audiowrite('HearingAidRecording.wav', audioData, Fs);

% Perform FFT on the recorded audio data
Y = fft(audioData);
L = length(Y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

% Plot the frequency spectrum
figure;
plot(f, 20*log10(P1));
title('Frequency Spectrum of Hearing Aid Recording');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
