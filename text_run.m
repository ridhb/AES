clc, clear all
% 
input='jakartaqjakartaq';
for j=1:16
    yy=dec2bin(double(input(j)),8);
    for i=1:8
        y(i+8*(j-1))=str2num(yy(i));
    end
end
save y
% y1=reshape(de2bi(double(input),8,'left-msb')',1,8*length(input))

% % y=ones(1,128)
% 
% 
kunci_rc5=ones(1,128);

hasil_enkrip=enkripsi_aes(y, kunci_rc5)

b='';c='';
Out=hasil_enkrip;
for i=1:64
    a=num2str(Out(i));
    b=[b a];
end

for i=1:8
    d=bin2dec(b(i*8-7:i*8));
    output(i)=char(d)
end

Out=dekripsi_aes(hasil_enkrip, kunci_rc5);


b='';c='';

for i=1:128
    a=num2str(Out(i));
    b=[b a];
end

for i=1:16
    d=bin2dec(b(i*8-7:i*8));
    output(i)=char(d)
end

%clear