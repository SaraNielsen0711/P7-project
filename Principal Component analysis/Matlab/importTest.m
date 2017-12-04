close all
clear all
clc

filename = 'C:\Users\Emil-\OneDrive\Documents\GitHub\P7-project\Principal Component analysis\Matlab\breaddata_attributes.csv';
delimiter = ',';
startRow = 2;

formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

fclose(fileID);

Data = [dataArray{1:end-1}];
clearvars filename delimiter startRow formatSpec fileID dataArray ans;