 function [xcf,ycf, id] = getheadingandid(x,y,im_c,inpix,ii)
%GETHEADINGANDID Summary of this function goes here
%   Detailed explanation goes here
P=30;
% im_c=imcrop(im,[x-P y-P 2*P 2*P]);
% im_c2=imcrop(im,[25 25 20 20]);
% imtool(im_c)
im_g=rgb2gray(im_c);
if(ii==2)
offst=-0.000;
else
    offst=0;
end
level = graythresh(imcrop(im_g,[23.5 23.5 17 16]))+offst;
im_cbw=im2bw(im_g,level);
f=0;
% figure
% imshow(im_cbw)
im_cbw=~bwareaopen(~im_cbw, 300);
im_cbw2=bwareaopen(im_cbw, 200);
% imshow(im_cbw2)

im_cbw=im_cbw-im_cbw2;
 
% imshow(im_cbw)

im_cbw2=bwareaopen(im_cbw, inpix);


%  figure
% imshow(im_cbw2)
% figure
% imshow(im_cbw)
% subplot(2,1,1)
% imshow(im_cbw2)
[ys1 xs1 c]=size(im_cbw2);

i_s=[];
j_s=[];

for i=1:xs1
    for j=1:ys1
        
        if (im_cbw2(j,i)~=0)
            i_s=[i_s i];
            j_s=[j_s j];
        end
    end
end

if length(i_s)~=0
    xcf= ((min(i_s)+ max(i_s))/2)+x-P;
    ycf= ((min(j_s)+ max(j_s))/2)+y-P;
    
    
else
    xcf=8000;
    ycf=8000;
    f=1;
end

% im_cbw=im_cbw-im_cbw2;
% 
%   figure
% subplot(2,1,2)
%   imshow(im_cbw)
% 
% 
% i_s=[];
% j_s=[];
% 
% for i=20:xs1-10
%     for j=20:ys1-10
%         
%         if (im_cbw(j,i)~=0)
%             i_s=[i_s i];
%             j_s=[j_s j];
%         end
%     end
% end
% 
 if (length(i_s)~=0 && f==0)
%     xcb= ((min(i_s)+ max(i_s))/2+P)*0.5+x-P;
%     ycb= ((min(j_s)+ max(j_s))/2+P)*0.5+y-P;
%     
%     rb=im_c(ceil(ycb-y+P),ceil(xcb-x+P),1);
%     gb=im_c(ceil(ycb-y+P),ceil(xcb-x+P),2);
%     bb=im_c(ceil(ycb-y+P),ceil(xcb-x+P),3);
    
    rb=im_c(P,P,1);
    gb=im_c(P,P,2);
    bb=im_c(P,P,3);
    rf=im_c(ceil(ycf-y+P),ceil(xcf-x+P),1);
    gf=im_c(ceil(ycf-y+P),ceil(xcf-x+P),2);
    bf=im_c(ceil(ycf-y+P),ceil(xcf-x+P),3);
%     imshow(im_c)
%     hold on
    
    if (rb>gb && rb>bb)
%         Cv_b=[1,0,0];
        hd=0;
    elseif (gb>bb && gb>rb)
%        Cv_b=[255,153,204]*255^-1;
%        Cv_b=[0,1,0];
hd=1;
    else
        hd=2;
%          Cv_b=[0,0,1];
    end
    
    if (rf>bf && rf>gf)
        ld=0;
%         Cv_f=[1,0,0];
        
    elseif (gf>bf && gf>rf )
        ld=1;
%                 Cv_f=[255,153,204]*255^-1;
%        Cv_f=[0,1,0];

    else
        ld=2;
%         Cv_f=[0,0,1];
    end
    
    %
    % plot(xcf-x+P,ycf-y+P,'*','color',[255,153,204]*255^-1)
    % plot(xcb-x+P,ycb-y+P,'*','color',[rc,gc,bc]*255^-1)
    % hold off
    
    id=hd*3+ld+1;
    
    
else
    xcb=8000;
    ycb=8000;
    id=200;
%     Cv_b=[1,1,1] ;
%     Cv_f=[1,1,1] ;
end

%   h=atan2(ys1-P,xs1-P)
% [center_in,rad_in] = imfindcircles(im_cbw,[7 15]);
% center_in
% heading=atan2(center_in(2)-40,center_in(1)-40)*180/pi
%
% hold on
%  plot(xs1,ys1,'r*')
%  plot(40,40,'g*')


% %
%
end

