function [cmd1,cmd2] = xbee_send( h,x,y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global s
DestAddrH='FF';
DestAddrL='FF';

% h=[1.11 2.22 3.33 4.44 5.55 6.66 7.77 8.88 9.99 10.1010];
% x=[1.11 2.22 3.33 4.44 5.55 6.66 7.77 8.88 9.99 10.1010]*2;
% y=[1.11 2.22 3.33 4.44 5.55 6.66 7.77 8.88 9.99 10.1010]*-1;
data_xb=999*ones(10,18);
for i=1:10 
if (h(i)>=0)
    sh='+';
else sh='-';
end
if (x(i)>=0)
    sx='+';
else sx='-';
end
if (y(i)>=0)
    sy='+';
else sy='-';
end
% data_xb=zeros(10,1);
H=num2str( round(abs(h(i)*100)));
X=num2str( round(abs(x(i)*100)));
Y=num2str( round(abs(y(i)*100)));

while (length(Y)<5)
    Y=['0' Y];
end
while (length(H)<5)
    H=['0' H];
end
while (length(X)<5)
    X=['0' X];
end
% size([ sh H sx  X sy  Y ])
    data_xb(i,:)=[ sh H sx  X sy  Y ];

end
sm=0;
size_p=5*length(data_xb(1,:))+6;
for j=1:5
sm=sm+sum(data_xb(j,:));
end
checksum=(01+00+01+hex2dec(DestAddrH)+hex2dec(DestAddrL)+sm);
chhex=dec2hex(checksum);

chhex=[chhex(length(chhex)-1) chhex(length(chhex))];
checkout=255-hex2dec(chhex);



cmd1=[hex2dec('7E'),00,size_p,01,00,hex2dec(DestAddrH),hex2dec(DestAddrL), 00, data_xb(1,:),data_xb(2,:),data_xb(3,:),data_xb(4,:),data_xb(5,:),01,checkout];

sm=0;
for j=6:10
sm=sm+sum(data_xb(j,:));
end
checksum=(01+00+02+hex2dec(DestAddrH)+hex2dec(DestAddrL)+sm);
chhex=dec2hex(checksum);

chhex=[chhex(length(chhex)-1) chhex(length(chhex))];
checkout=255-hex2dec(chhex);



 cmd2=[hex2dec('7E'),00,size_p,01,00,hex2dec(DestAddrH),hex2dec(DestAddrL), 00, data_xb(6,:),data_xb(7,:),data_xb(8,:),data_xb(9,:),data_xb(10,:),02,checkout];





% s = serial('COM7','BaudRate',57600,'DataBits',8);
% % set(s,'BaudRate',9600);
% fopen(s);
% s.Timeout=3;
%   fwrite(s,cmd1);
%   pause(0.05);
% 
%  fwrite(s,cmd2);
% 
% % out = fscanf(s);
% fclose(s);
% delete(s);
% clear s;

end

