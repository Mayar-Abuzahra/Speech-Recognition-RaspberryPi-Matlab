%Distiguish between Hi and Bye words using energy,ZCR and PSD approaches
training_files_Hi=dir('C:\Users\Dell\Desktop\dsp\train\Hi\*.wav');
training_files_Bye=dir('C:\Users\Dell\Desktop\dsp\train\Bye\*.wav');
testing_files_Hi=dir('C:\Users\Dell\Desktop\dsp\test\Hi\*.wav');
testing_files_Bye=dir('C:\Users\Dell\Desktop\dsp\test\Bye\*.wav');

data_Hi = [];
for i = 1:length(training_files_Hi)
file_path = strcat(training_files_Hi(i).folder,'\',training_files_Hi(i).name);
[y,fs] = audioread(file_path);
%taking 3 ZCR
ZCR_Hi1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_Hi2 = mean(abs(diff(sign(y(floor(end/3):floor(end*2/3))))))./2;
ZCR_Hi3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
ZCR_Hi = [ZCR_Hi1 ZCR_Hi2 ZCR_Hi3 energy psd];
data_Hi =[data_Hi ;ZCR_Hi];
end
ZCR_Hi = mean(data_Hi);
fprintf('The ZCR of Hi is \n');
disp(ZCR_Hi);

data_Bye = [];
for i = 1:length(training_files_Bye)
file_path = strcat(training_files_Bye(i).folder,'\',training_files_Bye(i).name);
[y,fs] = audioread(file_path);
%taking 3 ZCR
ZCR_Bye1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_Bye2 = mean(abs(diff(sign(y(floor(end/3):floor(end*2/3))))))./2;
ZCR_Bye3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
ZCR_Bye = [ZCR_Bye1 ZCR_Bye2 ZCR_Bye3 energy psd];
data_Bye =[data_Bye ;ZCR_Bye];
end
ZCR_Bye = mean(data_Bye);
fprintf('The ZCR of Bye is \n');
disp(ZCR_Bye);


%check if the sound is hi or bye word
for i = 1:length(testing_files_Hi)
file_path = strcat(testing_files_Hi(i).folder,'\',testing_files_Hi(i).name);
[y,fs] = audioread(file_path);
%taking 3 ZCR
ZCR_Hi1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_Hi2 = mean(abs(diff(sign(y(floor(end/3):floor(end*2/3))))))./2;
ZCR_Hi3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
y_ZCR = [ZCR_Hi1 ZCR_Hi2 ZCR_Hi3 energy psd];
    if(pdist([y_ZCR;ZCR_Hi],'cosine') < pdist([y_ZCR;ZCR_Bye],'cosine'))
        fprintf('Test file [Hi] #%d classified as Hi \n',i);
    else
        fprintf('Test file [Hi] #%d classified as Bye \n',i);
    end
end

for i = 1:length(testing_files_Bye)
file_path = strcat(testing_files_Bye(i).folder,'\',testing_files_Bye(i).name);
[y,fs] = audioread(file_path);
%taking 3 ZCR
ZCR_Bye1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_Bye2 = mean(abs(diff(sign(y(floor(end/3):floor(end*2/3))))))./2;
ZCR_Bye3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
y_ZCR = [ZCR_Bye1 ZCR_Bye2 ZCR_Bye3 energy psd];
    if(pdist([y_ZCR;ZCR_Hi],'cosine') < pdist([y_ZCR;ZCR_Bye],'cosine'))
        fprintf('Test file [Bye] #%d classified as Hi \n',i);
    else
        fprintf('Test file [Bye] #%d classified as Bye \n',i);
    end
end