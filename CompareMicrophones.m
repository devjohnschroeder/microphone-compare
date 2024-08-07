% Load the audio data for each device
[polyAudio, Fs] = audioread('PolyVoyagerRecording.wav');
[macAudio, ~] = audioread('MacBookRecording.wav');
[hearingAidAudio, ~] = audioread('HearingAidRecording.wav');

% Perform FFT on each audio data set
Y_poly = fft(polyAudio);
Y_mac = fft(macAudio);
Y_hearingAid = fft(hearingAidAudio);

% Compute magnitude spectra
L_poly = length(Y_poly);
L_mac = length(Y_mac);
L_hearingAid = length(Y_hearingAid);

P2_poly = abs(Y_poly/L_poly);
P1_poly = P2_poly(1:L_poly/2+1);
P1_poly(2:end-1) = 2*P1_poly(2:end-1);

P2_mac = abs(Y_mac/L_mac);
P1_mac = P2_mac(1:L_mac/2+1);
P1_mac(2:end-1) = 2*P1_mac(2:end-1);

P2_hearingAid = abs(Y_hearingAid/L_hearingAid);
P1_hearingAid = P2_hearingAid(1:L_hearingAid/2+1);
P1_hearingAid(2:end-1) = 2*P1_hearingAid(2:end-1);

% Frequency vector
f_poly = Fs*(0:(L_poly/2))/L_poly;
f_mac = Fs*(0:(L_mac/2))/L_mac;
f_hearingAid = Fs*(0:(L_hearingAid/2))/L_hearingAid;

% Plot all on the same figure for comparison
figure;
plot(f_poly, 20*log10(P1_poly), 'b', 'DisplayName', 'Poly Voyager');
hold on;
plot(f_mac, 20*log10(P1_mac), 'r', 'DisplayName', 'MacBook');
plot(f_hearingAid, 20*log10(P1_hearingAid), 'g', 'DisplayName', 'Hearing Aid');
hold off;

title('Frequency Spectrum Comparison of Different Microphones');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend;
grid on;
