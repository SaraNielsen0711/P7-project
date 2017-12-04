
clear all
close all
clc

run bread.m

%går ind og kigger for hver gang det tilsvarende bread# er i en række og
%printer det i en variabel, samt kigger
labels = [1,2,3,4,5,6,7,8,9,10,11];

bread1_idx = find(Data(:,3)==1);
breadAttr1 = Data(bread1_idx,5:end);
bread1=[labels;breadAttr1];
clear bread1_idx
clear breadAttr1

bread2_idx = find(Data(:,3)==2);
breadAttr2 = Data(bread2_idx,5:end);
bread2=[labels;breadAttr2];
clear bread2_idx
clear breadAttr2

bread3_idx = find(Data(:,3)==3);
breadAttr3 = Data(bread3_idx,5:end);
bread3=[labels;breadAttr3];
clear bread3_idx
clear breadAttr3

bread4_idx = find(Data(:,3)==4);
breadAttr4 = Data(bread4_idx,5:end);
bread4=[labels;breadAttr4];
clear bread4_idx
clear breadAttr4

bread5_idx = find(Data(:,3)==5);
breadAttr5 = Data(bread5_idx,5:end);
bread5=[labels;breadAttr5];
clear bread5_idx
clear breadAttr5

bread6_idx = find(Data(:,3)==6);
breadAttr6 = Data(bread6_idx,5:end);
bread6=[labels;breadAttr6];
clear bread6_idx
clear breadAttr6

bread7_idx = find(Data(:,3)==7);
breadAttr7 = Data(bread7_idx,5:end);
bread7=[labels;breadAttr7];
clear bread7_idx
clear breadAttr7

bread8_idx = find(Data(:,3)==8);
breadAttr8 = Data(bread8_idx,5:end);
bread8=[labels;breadAttr8];
clear bread8_idx
clear breadAttr8
clear labels
mean1 = mean(bread1);
mean2 = mean(bread2);
mean3 = mean(bread3);
mean4 = mean(bread4);
mean5 = mean(bread5);
mean6 = mean(bread6);
mean7 = mean(bread7);
mean8 = mean(bread8);


input_data=[mean1;mean2;mean3;mean4;mean5;mean6;mean7;mean8];
[coefs,scores,variances,tstat,explained] = pca(input_data); 
scree = plot([0:7],[0,explained(1),sum(explained(1:2)),sum(explained(1:3)),sum(explained(1:4)),sum(explained(1:5)),sum(explained(1:6)),sum(explained(1:7))])
 xlabel('Dimensions');
 ylabel('Stress')
hold on 
bar(1:7,explained, 'b');
ylim([0 100]);
hold off
figure; plot(scores(:,1),scores(:,2),'+') 
xlabel(['Principal Component 1 (' num2str(explained(1),'%.1f') '%)']) 
ylabel(['Principal Component 2 (' num2str(explained(2),'%.1f') '%)']) 
text(scores(1,1),scores(1,2),'Sample1') 
text(scores(2,1),scores(2,2),'Sample2') 
text(scores(3,1),scores(3,2),'Sample3') 
text(scores(4,1),scores(4,2),'Sample4')
text(scores(5,1),scores(5,2),'Sample5')
text(scores(6,1),scores(6,2),'Sample6')
text(scores(7,1),scores(7,2),'Sample7')
text(scores(8,1),scores(8,2),'Sample8')
%%pcaBread1=pca(mean1);
%%cov=pcacov(mean1);
