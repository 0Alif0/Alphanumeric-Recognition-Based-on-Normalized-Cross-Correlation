clc
close all;
input1 = imread('templates.bmp');

input2 = imread('B.bmp');

[hei, wei] = size(input1);
[hei2, wei2] = size(input2);
   
sum=0;
for i=1:hei2
    for j = 1:wei2    %candi intencity valu
        sum = sum + input2(i,j);
    end;
end
mp = sum/(wei2*hei2); % re 

store = zeros(1,10);  % zeros initily 
current=1;
for p = 1:10
    sum=0;
    for i = 1:hei
        for j = current:current+29
            sum = sum+input1(i,j); % 1st block
        end
    end
    mt=sum/(wei2*hei2);
    
    sum1=0;
    sum2=0;
    sum3=0;
    a=1;
    for i = 1:hei
        b=1;
        for j = current:current+29
            sum1 = sum1 + (input1(i,j)-mt)*(input2(a,b)-mp);
            sum2 = sum2 + (input1(i,j)-mt)^2;
            sum3 = sum3 + (input2(a,b)-mp)^2;
            b=b+1;
        end
        
        a=a+1;
    end
    ncc=sum1/sqrt(sum2*sum3);
    store(p) = ncc;
    current = current+30;
end
fprintf('Value of Stored Array\n');
for k=1:10
    fprintf('%.3f ',store(k));
end
[val,idx] = max(store);
fprintf('\nPattern Matched With %d\n', idx);
subplot(3,1,1);
subimage(input1);title('Database');
subplot(3,1,2);
subimage(input2);title('Cndidate Image');
subplot(3,1,3);
subimage(input1);title('Best Match shown by rectangle box');
rectangle('Position',[(idx-1)*wei2 1 wei2 hei2], 'Edgecolor','y');






