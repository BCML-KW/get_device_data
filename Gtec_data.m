%% Gtec
fileLocation = 'F:\2020_리클라이너\600Hz_Apr\HSW0514A\';
X = dir([fileLocation '*.mat']);
Y = [];
for i = 1:length(X)
    load([fileLocation X(i).name]);
    y = squeeze(y);
    Y = [Y ;y'];
    i
end
save([fileLocation X(i).name(1:end-9) '.mat'], 'Y');
fs = 600;
time = '1359-1659';
fileName = X(i).name(1:end-9);
% condition = X(i).name(1:end-29);
condition = fileLocation(end-8:end-1);
time1 = str2num(time(1:2))*60+str2num(time(3:4)); % 실험시작(분)
time2 = str2num(fileName(end-7:end-6))*60+str2num(fileName(end-4:end-3))+1;% 측정시작(분)
startTimeStamp = (time1-time2)*60*fs;
%startTimeStamp = (3600-(str2num(fileName(end-4:end-3))*60+str2num(fileName(end-1:end))))*fs;
duration = (3*60)*60*fs;
    YY = Y(startTimeStamp+1:startTimeStamp+duration,:);

EEG1 = YY(:,2);
EEG2 = YY(:,3);
ECG = YY(:,4);
save(['F:\2020_리클라이너\ECG\600Hz\ECG_' condition '_' time '.mat'], 'ECG');
save(['F:\2020_리클라이너\EEG\600Hz\EEG1_' condition '_' time '.mat'], 'EEG1');
save(['F:\2020_리클라이너\EEG\600Hz\EEG2_' condition '_' time '.mat'], 'EEG2');
leng = length(YY);
hh=fix(leng/3600/fs);
mm=fix((leng-hh*3600*fs)/fs/60);
ss=(leng-hh*3600*fs-mm*60*fs)/fs;
[hh mm ss]

%% Biopac
fileLocation = 'F:\2020_리클라이너\500Hz_Jul\BJW0721B_1317\';
X = dir([fileLocation '\*.mat']);
load([fileLocation X(1).name]);
fs = 500;
condition = X.name(1:8);
time = '1330-1630';
time1 = str2num(time(1:2))*60+str2num(time(3:4)); % 실험시작(분)
time2 = str2num(X.name(10:11))*60+str2num(X.name(12:13)); % 측정시작(분)
startTimeStamp = (time1-time2)*60*fs;
duration = 3*3600*fs;

% EEG1 = data(end-3*3600*fs:end-1,1);
% EEG2 = data(end-3*3600*fs:end-1,2);
% ECG = data(end-3*3600*fs:end-1,3);
EEG1 = data(startTimeStamp:startTimeStamp+duration-1,1);
EEG2 = data(startTimeStamp:startTimeStamp+duration-1,2);
ECG = data(startTimeStamp:startTimeStamp+duration-1,3);
save(['F:\2020_리클라이너\500Hz_Jul\ECG\ECG_' condition '_' time '.mat']', 'ECG');
save(['F:\2020_리클라이너\500Hz_Jul\EEG\EEG1_' condition '_' time '.mat']', 'EEG1');
save(['F:\2020_리클라이너\500Hz_Jul\EEG\EEG2_' condition '_' time '.mat']', 'EEG2');
leng = length(ECG);
hh=fix(leng/3600/fs);
mm=fix((leng-hh*3600*fs)/fs/60);
ss=(leng-hh*3600*fs-mm*60*fs)/fs;
[hh mm ss]
%% E4wristband
fileLocation = 'F:\2020_리클라이너\E4wristband_Jul\BJW0714H_14;38\';
data = csvread([fileLocation 'ACC.csv'],2,0);
fs = 32;
time0 = '1330'; % 실험시작(분)
time00 = '1321'; % 측정시작(분)
time1 = str2num(time0(1:2))*60+str2num(time0(3:4));
time2 = str2num(time00(1:2))*60+str2num(time00(3:4));
startTimeStamp = (time1-time2)*60*fs;
duration = 3*3600*fs;
Act = data(startTimeStamp:startTimeStamp+duration-1,:);
save(['F:\2020_리클라이너\E4wristband_Jul\Actigraphy data\32Hz\' fileLocation(end-8:end-1) '.mat']', 'Act');

%% Actigraph
fileLocation = 'F:\2020_리클라이너\E4wristband_Jul\KKH0731H\';
data = csvread([fileLocation 'MOS2E38180923 (2020-07-31)RAW.csv'],11,0);
fs = 100;
time0 = '1400'; % 실험시작(분)
time00 = '1359'; % 측정시작(분)
time1 = str2num(time0(1:2))*60+str2num(time0(3:4));
time2 = str2num(time00(1:2))*60+str2num(time00(3:4));
startTimeStamp = (time1-time2)*60*fs;
duration = (3*60)*60*fs;
Act = data(startTimeStamp+1:startTimeStamp+duration,:);
save(['F:\2020_리클라이너\E4wristband_Jul\Actigraphy data\100Hz\' fileLocation(end-8:end-1) '.mat'], 'Act');
csvwrite(['F:\2020_리클라이너\E4wristband_Jul\Actigraphy data\100Hz\' fileLocation(end-8:end-1) '.csv'], Act);


%% BCG
A=[];
X = dir(['F:\Sleep_data\BCG\Data\All_data\BCG_100Hz\*.mat']);
fileLocation = 'F:\Sleep_data\BCG\Data\All_data\BCG_100Hz\';
fs = 100;
for i=1:length(X)
 load([fileLocation X(i).name]);
 fileName = X(i).name(1:end-4);
startTimeStamp = (3600-(str2num(fileName(end-4:end-3))*60+str2num(fileName(end-1:end))))*fs;
duration = 7*3600*fs;
if startTimeStamp ~= 360000
    BCG2 = BCG(startTimeStamp:startTimeStamp+duration-1);
    BCG = BCG2;
end
save(['F:\Sleep_data\BCG\Data\All_data\new_BCG_100Hz\' fileName(1:14)],'BCG');
i
leng = length(BCG);
hh=fix(leng/3600/fs);
mm=fix((leng-hh*3600*fs)/fs/60);
ss=(leng-hh*3600*fs-mm*60*fs)/fs;
A = [A;hh mm ss];


end



%%
XX= dir(['F:\Sleep_data\BCG\Data\BCG_1105\xyz_1105_savedata*.mat']);
fileLocation = 'F:\Sleep_data\BCG\Data\BCG_1105\';
data = [];
T=[];
for i=1:44
    load([fileLocation XX(i).name]);
    data = [data;save_data];
    T=[T;save_t];
    i
end
fs=100;
fileName = 'xyz_1105_05_Nov_2019_22_52_13';
startTimeStamp = (3600-(str2num(fileName(end-4:end-3))*60+str2num(fileName(end-1:end))))*fs;
duration = 7*3600*fs;
BCG = data(startTimeStamp:startTimeStamp+duration-1,2);
save(['F:\Sleep_data\BCG\Data\All_data\1105Z_BCG_최윤석A_05_Nov_2019_22_52_13.mat'], 'BCG');
BCG=[];
BCG = data(startTimeStamp:startTimeStamp+duration-1,3);
save(['F:\Sleep_data\BCG\Data\All_data\1105Y_BCG_하헌재A_05_Nov_2019_22_52_13.mat'], 'BCG');
BCG = data(startTimeStamp:startTimeStamp+duration-1,4);
save(['F:\Sleep_data\BCG\Data\All_data\1105X_BCG_김준엽A_05_Nov_2019_22_52_13.mat'], 'BCG');


%%
X = dir(['F:\Sleep_data\Gtec\All_data\ECG_600Hz\*.mat']);
mkdir('F:\Sleep_data\Gtec\All_data\ECG_600Hz\ECG_600Hz')
fileLocation = 'F:\Sleep_data\Gtec\All_data\ECG_600Hz\';
fs = 600;
for i = 1:length(X)
    load([fileLocation X(i).name]);
    if exist('C1');if isfield(C1,'ECGa'); ECG = C1.ECGa; elseif isfield(C1,'ECGb'); ECG = C1.ECGb;end;
    elseif  exist('C2'); if isfield(C2,'ECGa'); ECG = C2.ECGa; elseif isfield(C2,'ECGb'); ECG = C2.ECGb;end;
    elseif  exist('C3'); if isfield(C3,'ECGa'); ECG = C3.ECGa; elseif isfield(C3,'ECGb'); ECG = C3.ECGb;end;
    elseif  exist('C4'); if isfield(C4,'ECGa'); ECG = C4.ECGa; elseif isfield(C4,'ECGb'); ECG = C4.ECGb;end;
    elseif  exist('C5'); if isfield(C5,'ECGa'); ECG = C5.ECGa; elseif isfield(C5,'ECGb'); ECG = C5.ECGb;end;
    elseif  exist('C6'); if isfield(C6,'ECGa'); ECG = C6.ECGa; elseif isfield(C6,'ECGb'); ECG = C6.ECGb;end;
    elseif  exist('C7'); if isfield(C7,'ECGa'); ECG = C7.ECGa; elseif isfield(C7,'ECGb'); ECG = C7.ECGb;end;
    elseif  exist('C8'); if isfield(C8,'ECGa'); ECG = C8.ECGa; elseif isfield(C8,'ECGb'); ECG = C8.ECGb;end;
    elseif  exist('C9'); if isfield(C9,'ECGa'); ECG = C9.ECGa; elseif isfield(C9,'ECGb'); ECG = C9.ECGb;end;
    elseif  exist('C10'); if isfield(C10,'ECGa'); ECG = C10.ECGa; elseif isfield(C10,'ECGb'); ECG = C10.ECGb;end;
    end        
    ECG = ECG';
    fileName = X(i).name(1:end-4);
    if i ==5 || i == 6
            startTimeStamp = (3600-(str2num(fileName(end-4:end-3))*60+str2num(fileName(end-1:end)))-33)*fs;
    else
    startTimeStamp = (3600-(str2num(fileName(end-4:end-3))*60+str2num(fileName(end-1:end))))*fs;
    end
    duration = 7*3600*fs;
    ECG2 = ECG(startTimeStamp:startTimeStamp+duration-1,:);
    
    leng = startTimeStamp+duration;
    leng = length(ECG);
    hh=fix(leng/3600/fs);
    mm=fix((leng-hh*3600*fs)/fs/60);
    ss=(leng-hh*3600*fs-mm*60*fs)/fs;
    [hh mm ss]
    
    ECG = ECG2;
    save([fileLocation 'ECG_600Hz\' fileName(1:15) '.mat'], 'ECG');
i
    clear ECG2 ECG
    clear C*


end

%%
X = dir(['F:\Sleep_data\Gtec\All_data\EEG_600Hz\*.mat']);
mkdir('F:\Sleep_data\Gtec\All_data\EEG_600Hz\EEG_600Hz')
fileLocation = 'F:\Sleep_data\Gtec\All_data\EEG_600Hz\';
fs = 600;
for i = 1:length(X)
    load([fileLocation X(i).name]);
%     if exist('C1');if isfield(C1,'ECGa'); ECG = C1.ECGa; elseif isfield(C1,'ECGb'); ECG = C1.ECGb;end;
%     elseif  exist('C2'); if isfield(C2,'ECGa'); ECG = C2.ECGa; elseif isfield(C2,'ECGb'); ECG = C2.ECGb;end;
%     elseif  exist('C3'); if isfield(C3,'ECGa'); ECG = C3.ECGa; elseif isfield(C3,'ECGb'); ECG = C3.ECGb;end;
%     elseif  exist('C4'); if isfield(C4,'ECGa'); ECG = C4.ECGa; elseif isfield(C4,'ECGb'); ECG = C4.ECGb;end;
%     elseif  exist('C5'); if isfield(C5,'ECGa'); ECG = C5.ECGa; elseif isfield(C5,'ECGb'); ECG = C5.ECGb;end;
%     elseif  exist('C6'); if isfield(C6,'ECGa'); ECG = C6.ECGa; elseif isfield(C6,'ECGb'); ECG = C6.ECGb;end;
%     elseif  exist('C7'); if isfield(C7,'ECGa'); ECG = C7.ECGa; elseif isfield(C7,'ECGb'); ECG = C7.ECGb;end;
%     elseif  exist('C8'); if isfield(C8,'ECGa'); ECG = C8.ECGa; elseif isfield(C8,'ECGb'); ECG = C8.ECGb;end;
%     elseif  exist('C9'); if isfield(C9,'ECGa'); ECG = C9.ECGa; elseif isfield(C9,'ECGb'); ECG = C9.ECGb;end;
%     elseif  exist('C10'); if isfield(C10,'ECGa'); ECG = C10.ECGa; elseif isfield(C10,'ECGb'); ECG = C10.ECGb;end;
%     end        
    if isfield(EEG1, 'EEG1a'); EEG(:,1) = EEG1.EEG1a';
    elseif isfield(EEG1, 'EEG1b'); EEG(:,1) = EEG1.EEG1b';
    end
    if isfield(EEG2, 'EEG2a'); EEG(:,2) = EEG2.EEG2a';
    elseif isfield(EEG2, 'EEG2b'); EEG(:,2) = EEG2.EEG2b';
    end
    fileName = X(i).name(1:end-4);
    if i ==5 || i == 6
    startTimeStamp = (3600-(str2num(fileName(end-4:end-3))*60+str2num(fileName(end-1:end)))-33)*fs;
    else
    startTimeStamp = (3600-(str2num(fileName(end-4:end-3))*60+str2num(fileName(end-1:end))))*fs;
    end
    duration = 7*3600*fs;
    EEG22 = EEG(startTimeStamp:startTimeStamp+duration-1,:);
    
    leng = startTimeStamp+duration;
    leng = length(EEG);
    hh=fix(leng/3600/fs);
    mm=fix((leng-hh*3600*fs)/fs/60);
    ss=(leng-hh*3600*fs-mm*60*fs)/fs;
    [hh mm ss]
    
    EEG = EEG22;
    save([fileLocation 'EEG_600Hz\' fileName(1:15) '.mat'], 'EEG');
i
    clear EEG22 EEG
    clear EEG1 EEG2


end
