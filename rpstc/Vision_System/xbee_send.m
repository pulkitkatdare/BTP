function [nPkt] = xbee_send( sp, h,x,y,t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

DestAddrH='FF';
DestAddrL='FF';
x=single(x);
y=single(y);
h=single(h);
t=single(t);

%Number of bots
nBot = length(h);

% Number of packets to be sent
nPkt = floor((nBot-1)/7) + 1;

for pkt_cnt=0:nPkt-1
    data_xb=[];
    for  i=1:7
        indx = 7*pkt_cnt + i ;
        if(indx <= nBot)
            data_ag=[typecast(x(indx),'uint8') typecast(y(indx),'uint8') typecast(h(indx),'uint8') ];
        else
            data_ag=[typecast(single(999),'uint8') typecast(single(999),'uint8') typecast(single(999),'uint8') ];
        end
        data_xb=[data_xb  data_ag ];
    end
    data_xb=[data_xb typecast(t,'uint8') uint8(pkt_cnt)];
    
    sm=0;
    size_p=length(data_xb(1,:))+5;
    
    sm=sm+sum(data_xb(1,:));
    
    checksum=(01+00+hex2dec(DestAddrH)+hex2dec(DestAddrL)+sm);
    chhex=dec2hex(checksum);
    
    chhex=[chhex(length(chhex)-1) chhex(length(chhex))];
    checkout=255-hex2dec(chhex);
    
    cmd=[hex2dec('7E'),00,size_p,01,00,hex2dec(DestAddrH),hex2dec(DestAddrL), 00, data_xb(1,:),checkout];
    fwrite(sp ,cmd)    
end
end

