%Distiguish between gender and identifying Hi and Bye words using
%energy,ZCR and PSD approaches
training_files_female=dir('C:\Users\Dell\Desktop\dsp\train1\hfemale\*.wav');
training_files_male=dir('C:\Users\Dell\Desktop\dsp\train1\hmale\*.wav');
testing_files_female=dir('C:\Users\Dell\Desktop\dsp\test1\hfemale\*.wav');
testing_files_male=dir('C:\Users\Dell\Desktop\dsp\test1\hmale\*.wav');
training_files_femalee=dir('C:\Users\Dell\Desktop\dsp\train1\bfemale\*.wav');
training_files_malee=dir('C:\Users\Dell\Desktop\dsp\train1\bmale\*.wav');
testing_files_femalee=dir('C:\Users\Dell\Desktop\dsp\test1\bfemale\*.wav');
testing_files_malee=dir('C:\Users\Dell\Desktop\dsp\test1\bmale\*.wav');
data_hfemale = [];

for i = 1:length(training_files_female)
file_path = strcat(training_files_female(i).folder,'\',training_files_female(i).name);
[y,fs] = audioread(file_path);
ZCR_Hi1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Hi2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Hi3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Hi4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
ZCR_Hif = [ZCR_Hi1 ZCR_Hi2 ZCR_Hi3 ZCR_Hi4 energy psd];
data_hfemale = [data_hfemale;ZCR_Hif];
end
ZCR_Hif = mean(data_hfemale);
fprintf('The ZCR of hi female is \n');
disp(ZCR_Hif);

data_hmale = [];
for i = 1:length(training_files_male)
file_path = strcat(training_files_male(i).folder,'\',training_files_male(i).name);
[y,fs] = audioread(file_path);
ZCR_Hi1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Hi2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Hi3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Hi4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
ZCR_Him = [ZCR_Hi1 ZCR_Hi2 ZCR_Hi3 ZCR_Hi4 energy psd];
data_hmale = [data_hmale;ZCR_Him];
end
ZCR_Him = mean(data_hmale);
fprintf('The ZCR of hi male is \n');
disp(ZCR_Him);

for i = 1:length(testing_files_female)
file_path = strcat(testing_files_female(i).folder,'\',testing_files_female(i).name);  
[y fs] = audioread(file_path);
ZCR_Hi1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Hi2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Hi3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Hi4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
y_ZCR = [ZCR_Hi1 ZCR_Hi2 ZCR_Hi3 ZCR_Hi4 energy psd];
   if(pdist([y_ZCR;ZCR_Hif],'cosine') < pdist([y_ZCR;ZCR_Him],'cosine'))
       fprintf('Test file [hfemale] #%d classified as hi female\n',i); 
    else
       fprintf('Test file [hfemale] #%d classified as hi male\n',i); 
    end
end

for i = 1:length(testing_files_male)
file_path = strcat(testing_files_male(i).folder,'\',testing_files_male(i).name);  
[y fs] = audioread(file_path);
ZCR_Hi1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Hi2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Hi3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Hi4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
y_ZCR = [ZCR_Hi1 ZCR_Hi2 ZCR_Hi3 ZCR_Hi4 energy psd];
   if(pdist([y_ZCR;ZCR_Hif],'cosine') < pdist([y_ZCR;ZCR_Him],'cosine'))
       fprintf('Test file [hmale] #%d classified as hi female\n',i); 
    else
       fprintf('Test file [hmale] #%d classified as hi male\n',i); 
    end
end

data_bfemale = [];
for i = 1:length(training_files_femalee)
file_path = strcat(training_files_femalee(i).folder,'\',training_files_femalee(i).name);
[y,fs] = audioread(file_path);
ZCR_Bye1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Bye2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Bye3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Bye4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
ZCR_Byef = [ZCR_Bye1 ZCR_Bye2 ZCR_Bye3 ZCR_Bye4 energy psd];
data_bfemale = [data_bfemale;ZCR_Byef];
end
ZCR_byef = mean(data_bfemale);
fprintf('The ZCR of bye female is \n');
disp(ZCR_byef);

data_bmale = [];
for i = 1:length(training_files_malee)
file_path = strcat(training_files_malee(i).folder,'\',training_files_malee(i).name);
[y,fs] = audioread(file_path);
ZCR_Bye1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Bye2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Bye3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Bye4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
ZCR_Byem = [ZCR_Bye1 ZCR_Bye2 ZCR_Bye3 ZCR_Bye4 energy psd];
data_bmale = [data_bmale;ZCR_Byem];
end
ZCR_Byem = mean(data_bmale);
fprintf('The ZCR of Bye male is \n');
disp(ZCR_Byem);

for i = 1:length(testing_files_femalee)
file_path = strcat(testing_files_femalee(i).folder,'\',testing_files_femalee(i).name);  
[y fs] = audioread(file_path);
ZCR_Bye1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Bye2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Bye3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Bye4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
y_ZCR = [ZCR_Bye1 ZCR_Bye2 ZCR_Bye3 ZCR_Bye4 energy psd];
   if(pdist([y_ZCR;ZCR_Byef],'cosine') < pdist([y_ZCR;ZCR_Byem],'cosine'))
       fprintf('Test file [bfemale] #%d classified as Bye female\n',i); 
    else
       fprintf('Test file [bfemale] #%d classified as Bye male\n',i); 
    end
end

for i = 1:length(testing_files_malee)
file_path = strcat(testing_files_malee(i).folder,'\',testing_files_malee(i).name);  
[y fs] = audioread(file_path);
ZCR_Bye1 = mean(abs(diff(sign(y(1:floor(end/4))))))./2;
ZCR_Bye2 = mean(abs(diff(sign(y(floor(end/4):floor(end*1/2))))))./2;
ZCR_Bye3 = mean(abs(diff(sign(y(floor(end*1/2):floor(end*3/4))))))./2;
ZCR_Bye4 = mean(abs(diff(sign(y(floor(end*3/4):end)))))./2;
energy = sum(y.^2);
ydft = abs(fft(y));
psd = sum(ydft.^2);
y_ZCR = [ZCR_Bye1 ZCR_Bye2 ZCR_Bye3 ZCR_Bye4 energy psd];
   if(pdist([y_ZCR;ZCR_Byef],'cosine') < pdist([y_ZCR;ZCR_Byem],'cosine'))
       fprintf('Test file [bmale] #%d classified as Bye female\n',i); 
    else
       fprintf('Test file [bmale] #%d classified as Bye male\n',i); 
    end
end
