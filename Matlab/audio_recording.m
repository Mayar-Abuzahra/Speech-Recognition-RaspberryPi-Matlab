recObj = audiorecorder(44000,24,1);
for i=1:2
fprintf('Start speaking for audio #%d\n',i);
recordblocking(recObj,2);
fprintf('Audio #%d ended\n',i);
y = getaudiodata(recObj);
y = y - mean(y);
Ns=length(y);
Ns=Ns./44000;
disp(Ns);
file_name = sprintf('testt/test1/test1%d.wav',i);
audiowrite(file_name,y,recObj.SampleRate);
end
%Ns=length(y);
%N=8;
%psd =abs(fft(y,N));
%disp(psd);