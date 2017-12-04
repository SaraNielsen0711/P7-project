
clear all
close all
clc

run bread.m

%går ind og kigger for hver gang det tilsvarende bread# er i en række og
%printer det i en variabel, samt kigger
bread1_idx = find(Data(:,3)==1);
bread1 = Data(bread1_idx,5:end);
bread2_idx = find(Data(:,3)==2);
bread2 = Data(bread2_idx,5:end);
bread3_idx = find(Data(:,3)==3);
bread3 = Data(bread3_idx,5:end);
bread4_idx = find(Data(:,3)==4);
bread4 = Data(bread4_idx,5:end);
bread5_idx = find(Data(:,3)==5);
bread5 = Data(bread5_idx,5:end);
bread6_idx = find(Data(:,3)==6);
bread6 = Data(bread6_idx,5:end);
bread7_idx = find(Data(:,3)==7);
bread7 = Data(bread7_idx,5:end);
bread8_idx = find(Data(:,3)==8);
bread8 = Data(bread8_idx,5:end);

mean1 = mean(bread1);
%muligvis bør du regne

