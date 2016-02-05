%example me 'you got it' kai fwni mou 
%provlima: to tragoudi einai deigmatoliptimeno me fs=48Khz kai h fwni mou
%me fs=44Khz

clear all;
clc;
load('filters.mat');

 traindir = 'train-friends/'; 
 s=[];

 
    filename = sprintf('s%d.wav',6);
    [y,fs] = audioread(strcat(traindir,filename));
    %s(1,:) = filter(Hd,y);
    N=round(5*fs/2)-round(fs/2);
    s(1,:)= y(1:N);

    s(2,:)=(zeros(1,length(s)));
     
    filename = sprintf('s%d.wav',1);
    [y,fs] = audioread(strcat(traindir,filename));
    %s(1,:) = filter(Hd,y);
    s(2,:)= y(1:N); 

 % akoume tis 2 fwnes
 sound(s(1,:),fs);
 sound(s(2,:),fs);
 
 %������������� �� ������ ��� �����
figure;
subplot(2,1,1); plot(s(1,:)),grid on, title('You got it'), xlabel('t (msec)'); % plot s1
subplot(2,1,2); plot(s(2,:), 'r'),grid on, title('Anastasia'), xlabel('t (msec)'); % plot s2
 
 A=[0.5 0.3; 0.8 0.9];  %������������ ��� ������ �����
 x=[];
%for i=1:nFiles
    % x(i,:)=A(:,i)*s(i,:);       giati den douleuei???
    x=A*s;
%end

%������ �� ���� ��� ��� �������
sound(x(1,:),fs);
sound(x(2,:),fs);

% sxediazoume ti miksi
figure;
plot(x(1,:),'r');
hold on
plot(x(2,:),'b');
hold off;

c=fastica([x(1,:);x(2,:)]); % �������� ���������� fastICA

%������ ��� ����������� ���������� ��� ���������� � ���������� fastICA
sound(c(1,:),fs);
sound(c(2,:),fs);

%������������� ��� ����������� ���������� ��� ���������� � ���������� fastICA
figure;
subplot(2,1,1); plot(c(1,:)), grid on,title('You got it'), xlabel('t (msec)');
subplot(2,1,2); plot(c(2,:),'r'), grid on, title('Anastasia'), xlabel('t (msec)');