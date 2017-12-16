%  This script runs a PCA analysis for the entire dataset, but also based 
%  on some groupings. Comments are included on the section for the "Tech" 
%  grouping to describe the process of sorting the data and doing the PCA 
%  analysis and making the plots. The procedure is the same for the other 
%  groupings and therefore won't be commented again. In the bottom of this 
%  script, there is a cleanup function, to remove all the unnecessary 
%  variables from the workspace. Add the variables in that function that 
%  you want to keep.
%  
%  In order to run the script, you need a dataset with all the ratings in
%  different columns (wide-format), and the importP7.m file. In the import
%  file, make sure to correct the path to the location of the dataset. In 
%  case a different dataset is used, remember to correct which columns the
%  functions should use in this script. Each section in this script makes
%  the PCA including scree+bar plot, score plot and biplot. The biplot
%  can be 2D or 3D.

close all

% Imports data set using the import-script in importP7.m
run importP7.m

labels = [1:23];
varlabels = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23',};

% Color codes used to make it look like excel. Only used in RHeight, since
% they are used in the article.
blue=[.26666666,.4431372549,.76862745098];
orange=[.9294117647, .49019607843, .19215686274];

%% Tech

% Sort the data into three approximately equal sized groups, depending on 
% how much they like technology. Output: datafile for each of the three 
% groups, with subject ID on rows and scale questions on columns
tech1_idx = find(Data(:,6)<70);
techAttr1 = Data(tech1_idx,7:29);
tech1=[labels;techAttr1];

tech2_idx = find(Data(:,6)>65 & Data(:,6)<90);
techAttr2 = Data(tech2_idx,7:29);
tech2=[labels;techAttr2];

tech3_idx = find(Data(:,6)>90);
techAttr3 = Data(tech3_idx,7:29);
tech3=[labels;techAttr3];


% Take mean of each columns in the three groups and collect it all in one
% file. The nanmean ignores NaN values when calculating mean. Output: 
% datafile with all data sorted after tech-parameter. Different tech 
%groups in rows and scale questions in columns.
meanTech1 = nanmean(tech1);
meanTech2 = nanmean(tech2);
meanTech3 = nanmean(tech3);
inputTech=[meanTech1;meanTech2;meanTech3];


% Makes PCA analysis and returns relevant variables for making biplot, 
% scree and scoreplot.
[coefsTech,scoresTech,variancesTech,tstatTech,explainedTech] = pca(inputTech); 

% Makes combined scree-plot and barplot. Remember to check how many PC's
% there is (how many rows in explainedTech) and correct the following code 
% to include them all. In this case there is two principal components
figure;screeTech = plot(0:2,[0,explainedTech(1),sum(explainedTech(1:2))]);
  title('Scree-tech')
  xlabel('Principal Components');
  ylabel('Variance Explained [%]')
  hold on 
  bar(1:2,explainedTech, 'b');
  ylim([0 100]);
  hold off


% Makes scoreplot in two dimensions.
figure;scoresTechPlot = plot(scoresTech(:,1),scoresTech(:,2),'*'); 
title('Scores-tech')
xlabel(['Principal Component 1 (' num2str(explainedTech(1),'%.1f') '%)']) 
ylabel(['Principal Component 2 (' num2str(explainedTech(2),'%.1f') '%)']) 
text(scoresTech(1,1),scoresTech(1,2),'Lidt') 
text(scoresTech(2,1),scoresTech(2,2),'Mellem') 
text(scoresTech(3,1),scoresTech(3,2),'Meget')

% Makes biplot with scores and loadings in two dimensions. Change (:,1:2)
% to (:,1:3) to add a third dimension.
figure;biplot(coefsTech(:,1:2),'Scores', scoresTech(:,1:2),'varlabels',varlabels,'markersize', 10);
title('Biplot-tech')

% Adds labels to the 2D biplot
text(scoresTech(1,1)/45.73,scoresTech(1,2)/45.73,'Lidt','Color','r') 
text(scoresTech(2,1)/45.73,scoresTech(2,2)/45.73,'Mellem','Color','r') 
text(scoresTech(3,1)/45.73,scoresTech(3,2)/45.73,'Meget','Color','r')

% Adds labels to the 3D biplot. The number 45.73 is used to fit the positions 
% of the labels for the scores, since the dimensions are different in the
% biplot. They are hardcoded, and might therefore need to be changed for
% other applications. Sorry...
%text(scoresTech(1,1)/45.73,scoresTech(1,2)/45.73,scoresTech(1,3)/45.73,'Lidt','Color','r') 
%text(scoresTech(2,1)/45.73,scoresTech(2,2)/45.73,scoresTech(2,3)/45.73,'Mellem','Color','r') 
%text(scoresTech(3,1)/45.73,scoresTech(3,2)/45.73,scoresTech(3,3)/45.73,'Meget','Color','r')

xlabel(['Principal Component 1 (' num2str(explainedTech(1),'%.1f') '%)']) 
ylabel(['Principal Component 2 (' num2str(explainedTech(2),'%.1f') '%)']) 

% This label is only for the 3D-plot
%zlabel(['Principal Component 3 (' num2str(explainedTech(3),'%.1f') '%)']) 

%% Unsorted PCA for enitre dataset
%  
% [coefs,scores,variances,tstat,explained] = pca(Data(:,7:29),'Rows','complete'); 
% figure;scree = plot([0:7],[0,explained(1),sum(explained(1:2)),sum(explained(1:3)),sum(explained(1:4)),sum(explained(1:5)),sum(explained(1:6)),sum(explained(1:7))]);
%   title('Scree')
%   xlabel('Principal Components');
%   ylabel('Variance Explained [%]')
%   hold on 
%   bar(1:7,explained(1:7), 'b');
%   ylim([0 100]);
%   hold off
% 
% 
% % Makes scoreplot in two dimensions.
% figure;scoresPlot = plot(scores(:,1),scores(:,2),'*'); 
% title('Scores')
% xlabel(['Principal Component 1 (' num2str(explained(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explained(2),'%.1f') '%)']) 
% labelScore=1:43;
% labelScore=labelScore(:);
% text(scores(1:43,1)+1,scores(1:43,2)+4,num2str(labelScore(1:43))) 
% 
%  figure;biplot(coefs(:,1:3),'Scores', scores(:,1:3),'varlabels',varlabels,'markersize', 10);
% title('Biplot')
% 
% xlabel(['Principal Component 1 (' num2str(explained(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explained(2),'%.1f') '%)']) 
% zlabel(['Principal Component 3 (' num2str(explained(3),'%.1f') '%)']) 


% %% Travel
% 
% travel1_idx = find(Data(:,4)<5);
% travelAttr1 = Data(travel1_idx,7:29);
% travel1=[labels;travelAttr1];
% 
% travel2_idx = find(Data(:,4)>4 & Data(:,4)<18);
% travelAttr2 = Data(travel2_idx,7:29);
% travel2=[labels;travelAttr2];
% 
% travel3_idx = find(Data(:,4)>15);
% travelAttr3 = Data(travel3_idx,7:29);
% travel3=[labels;travelAttr3];
% 
% meanTravel1 = nanmean(travel1);
% meanTravel2 = nanmean(travel2);
% meanTravel3 = nanmean(travel3);
% inputTravel=[meanTravel1;meanTravel2;meanTravel3];
% 
% [coefsTravel,scoresTravel,variancesTravel,tstatTravel,explainedTravel] = pca(inputTravel); 
%  figure;screeTravel = plot(0:2,[0,explainedTravel(1),sum(explainedTravel(1:2))]);
%   title('Scree-travel')
%   xlabel('Principal Components');
%   ylabel('Variance Explained [%]')
%    hold on 
%   bar(1:2,explainedTravel, 'b');
%   ylim([0 100]);
%   hold off
% 
% figure; scoresTravelPlot = plot(scoresTravel(:,1),scoresTravel(:,2),'*'); 
% title('Scores-travel')
% xlabel(['Principal Component 1 (' num2str(explainedTravel(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedTravel(2),'%.1f') '%)']) 
% text(scoresTravel(1,1),scoresTravel(1,2),'Lidt') 
% text(scoresTravel(2,1),scoresTravel(2,2),'Mellem') 
% text(scoresTravel(3,1),scoresTravel(3,2),'Meget')
% 
% 
% figure;biplot(coefsTravel(:,1:2),'Scores', scoresTravel(:,1:2),'varlabels',varlabels,'markersize', 10);
% title('Biplot-travel')
% text(scoresTravel(1,1)/38.94,scoresTravel(1,2)/38.94,'Lidt','Color','r') 
% text(scoresTravel(2,1)/38.94,scoresTravel(2,2)/38.94,'Mellem','Color','r') 
% text(scoresTravel(3,1)/38.94,scoresTravel(3,2)/38.94,'Meget','Color','r')
% 
% 
% xlabel(['Principal Component 1 (' num2str(explainedTravel(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedTravel(2),'%.1f') '%)']) 
% 
% 
% 
% 
% 


%% Direction
% 
% direction1_idx = find(Data(:,33)==1);
% directionAttr1 = Data(direction1_idx,7:29);
% direction1=[labels;directionAttr1];
% 
% direction2_idx = find(Data(:,33)==2);
% directionAttr2 = Data(direction2_idx,7:29);
% direction2=[labels;directionAttr2];
% 
% direction3_idx = find(Data(:,33)==3);
% directionAttr3 = Data(direction3_idx,7:29);
% direction3=[labels;directionAttr3];
% 
% direction4_idx = find(Data(:,33)==4);
% directionAttr4 = Data(direction4_idx,7:29);
% direction4=[labels;directionAttr4];
% 
% 
% meanDirection1 = nanmean(direction1);
% meanDirection2 = nanmean(direction2);
% meanDirection3 = nanmean(direction3);
% meanDirection4 = nanmean(direction4);
% inputDirection=[meanDirection1;meanDirection2;meanDirection3;meanDirection4];
% 
% [coefsDirection,scoresDirection,variancesDirection,tstatDirection,explainedDirection] = pca(inputDirection); 
% coefsDirection=round(coefsDirection,4);
% figure; screeDirection = plot(0:3,[0,explainedDirection(1),sum(explainedDirection(1:2)),sum(explainedDirection(1:3))]);
%  title('Scree-direction')
%   xlabel('Principal Components');
%   ylabel('Variance Explained [%]')
%  hold on
%  bar(1:3,explainedDirection, 'b');
%  ylim([0 100]);
%  hold off
% 
% figure; scoresDirectionPlot = plot(scoresDirection(:,1),scoresDirection(:,2),'*'); 
% title('Scores-direction')
% xlabel(['Principal Component 1 (' num2str(explainedDirection(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedDirection(2),'%.1f') '%)']) 
% text(scoresDirection(1,1),scoresDirection(1,2),'Venstre') 
% text(scoresDirection(2,1),scoresDirection(2,2),'Forfra') 
% text(scoresDirection(3,1),scoresDirection(3,2),'Højre')
% text(scoresDirection(4,1),scoresDirection(4,2),'Kommer selv')
% 
% figure;biplot(coefsDirection(:,1:3),'Scores', scoresDirection(:,1:3),'varlabels',varlabels,'markersize', 10);
% title('Biplot-direction')
% 
% % text(scoresDirection(1,1)/76.38,scoresDirection(1,2)/76.38,'Venstre','Color','r') 
% % text(scoresDirection(2,1)/76.38,scoresDirection(2,2)/76.38,'Forfra','Color','r') 
% % text(scoresDirection(3,1)/76.38,scoresDirection(3,2)/76.38,'Højre','Color','r')
% % text(scoresDirection(4,1)/76.38,scoresDirection(4,2)/76.38,'Kommer selv','Color','r')
% 
% text(scoresDirection(1,1)/60,scoresDirection(1,2)/60,scoresDirection(1,3)/60,'Venstre','Color','r') 
% text(scoresDirection(2,1)/60,scoresDirection(2,2)/60,scoresDirection(2,3)/60,'Forfra','Color','r') 
% text(scoresDirection(3,1)/60,scoresDirection(3,2)/60,scoresDirection(3,3)/60,'Højre','Color','r')
% text(scoresDirection(4,1)/60,scoresDirection(4,2)/60,scoresDirection(4,3)/60,'Kommer selv','Color','r')
% 
% xlabel(['Principal Component 1 (' num2str(explainedDirection(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedDirection(2),'%.1f') '%)'])
% zlabel(['Principal Component 3 (' num2str(explainedDirection(3),'%.1f') '%)'])

%  %% Distance
% 
% distance1_idx = find(Data(:,32)==1);
% distanceAttr1 = Data(distance1_idx,7:29);
% distance1=[labels;distanceAttr1];
% 
% distance2_idx = find(Data(:,32)==2);
% distanceAttr2 = Data(distance2_idx,7:29);
% distance2=[labels;distanceAttr2];
% 
% distance3_idx = find(Data(:,32)==3);
% distanceAttr3 = Data(distance3_idx,7:29);
% distance3=[labels;distanceAttr3];
% 
% meanDistance1 = nanmean(distance1);
% meanDistance2 = nanmean(distance2);
% meanDistance3 = nanmean(distance3);
% inputDistance=[meanDistance1;meanDistance2;meanDistance3];
% 
% [coefsDistance,scoresDistance,variancesDistance,tstatDistance,explainedDistance] = pca(inputDistance); 
% coefsDistance=round(coefsDistance,4);
% figure; screeDistance = plot([0,1,2],[0,explainedDistance(1),sum(explainedDistance(1:2))]);
% 
% title('Scree-distance')
%   xlabel('Principal Components');
%   ylabel('Variance Explained [%]')
%   hold on 
%  bar(1:2,explainedDistance, 'b');
%  ylim([0 100]);
%  hold off
% 
% figure; plot(scoresDistance(:,1),scoresDistance(:,2),'*') 
% title('Scores-distance')
% xlabel(['Principal Component 1 (' num2str(explainedDistance(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedDistance(2),'%.1f') '%)']) 
% text(scoresDistance(1,1),scoresDistance(1,2),'Tæt på') 
% text(scoresDistance(2,1),scoresDistance(2,2),'Tilpas') 
% text(scoresDistance(3,1),scoresDistance(3,2),'Langt fra')
% 
% figure;biplot(coefsDistance(:,1:2),'Scores', scoresDistance(:,1:2),'varlabels',varlabels,'markersize', 10);
% title('Biplot-distance')
% text(scoresDistance(1,1)/51.6,scoresDistance(1,2)/51.6,'Tæt på','Color','r') 
% text(scoresDistance(2,1)/51.6,scoresDistance(2,2)/51.6,'Tilpas','Color','r') 
% text(scoresDistance(3,1)/51.6,scoresDistance(3,2)/51.6,'Langt fra','Color','r')
% 
% xlabel(['Principal Component 1 (' num2str(explainedDistance(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedDistance(2),'%.1f') '%)']) 

%% RHeight

Rheight1_idx = find(Data(:,30)==118);
RheightAttr1 = Data(Rheight1_idx,7:29);
Rheight1=[labels;RheightAttr1];

Rheight2_idx = find(Data(:,30)==123.5);
RheightAttr2 = Data(Rheight2_idx,7:29);
Rheight2=[labels;RheightAttr2];

Rheight3_idx = find(Data(:,30)==129);
RheightAttr3 = Data(Rheight3_idx,7:29);
Rheight3=[labels;RheightAttr3];

Rheight4_idx = find(Data(:,30)==140);
RheightAttr4 = Data(Rheight4_idx,7:29);
Rheight4=[labels;RheightAttr4];

Rheight5_idx = find(Data(:,30)==151);
RheightAttr5 = Data(Rheight5_idx,7:29);
Rheight5=[labels;RheightAttr5];


meanRHeight1 = nanmean(Rheight1);
meanRHeight2 = nanmean(Rheight2);
meanRHeight3 = nanmean(Rheight3);
meanRHeight4 = nanmean(Rheight4);
meanRHeight5 = nanmean(Rheight5);
inputRHeight=[meanRHeight1;meanRHeight2;meanRHeight3;meanRHeight4;meanRHeight5];

[coefsRHeight,scoresRHeight,variancesRHeight,tstatRHeight,explainedRHeight] = pca(inputRHeight); 
coefsRHeight=round(coefsRHeight,4);

figure;screeRHeight = bar(1:4,explainedRHeight,'facecolor',blue);
%  title('Scree-RHeight')
  xlabel('Principal Components');
  ylabel('Variance Explained (%)') 

ylim([0 100]);
 hold on
plot(0:4,[0,explainedRHeight(1),sum(explainedRHeight(1:2)),sum(explainedRHeight(1:3)),sum(explainedRHeight(1:4))],'color',orange,'linewidth',2);
 hold off

figure; scoresRHeigthplot =plot(scoresRHeight(:,1),scoresRHeight(:,2),'+'); 
title('Scores-RHeight')
xlabel(['Principal Component 1 (' num2str(explainedRHeight(1),'%.1f') '%)']) 
ylabel(['Principal Component 2 (' num2str(explainedRHeight(2),'%.1f') '%)']) 
text(scoresRHeight(1,1),scoresRHeight(1,2),'118') 
text(scoresRHeight(2,1),scoresRHeight(2,2),'123.5') 
text(scoresRHeight(3,1),scoresRHeight(3,2),'129') 
text(scoresRHeight(4,1),scoresRHeight(4,2),'140')
text(scoresRHeight(5,1),scoresRHeight(5,2),'151')
figure;biplot(coefsRHeight(:,1:2),'Scores', scoresRHeight(:,1:-3),'varlabels',varlabels,'Color',blue, 'linewidth',2,'markersize', 13);
%title('Robot Height Biplot')
hold on;
plot(scoresRHeight(1,1)/113.76,scoresRHeight(1,2)/113.76,'.','markersize',13,'Color',orange);
plot(scoresRHeight(2,1)/113.76,scoresRHeight(2,2)/113.76,'.','markersize',13,'Color',orange); 
plot(scoresRHeight(3,1)/113.76,scoresRHeight(3,2)/113.76,'.','markersize',13,'Color',orange);
plot(scoresRHeight(4,1)/113.76,scoresRHeight(4,2)/113.76,'.','markersize',13,'Color',orange);
plot(scoresRHeight(5,1)/113.76,scoresRHeight(5,2)/113.76,'.','markersize',13,'Color',orange);
% 
% text(scoresRHeight(1,1)/113.76,scoresRHeight(1,2)/113.76,'118','Color',red,'FontWeight','bold') 
% text(scoresRHeight(2,1)/113.76,scoresRHeight(2,2)/113.76,'123.5','Color',red,'FontWeight','bold') 
% text(scoresRHeight(3,1)/113.76,scoresRHeight(3,2)/113.76,'129','Color',red,'FontWeight','bold') 
% text(scoresRHeight(4,1)/113.76,scoresRHeight(4,2)/113.76,'140','Color',red,'FontWeight','bold')
% text(scoresRHeight(5,1)/113.76,scoresRHeight(5,2)/113.76,'151','Color',red,'FontWeight','bold')
% text(scoresRHeight(1,1)/90,scoresRHeight(1,2)/105,scoresRHeight(1,3)/100,'118','Color','r') 
% text(scoresRHeight(2,1)/90,scoresRHeight(2,2)/100,scoresRHeight(2,3)/100,'123.5','Color','r') 
% text(scoresRHeight(3,1)/90,scoresRHeight(3,2)/105,scoresRHeight(3,3)/100,'129','Color','r') 
% text(scoresRHeight(4,1)/90,scoresRHeight(4,2)/105,scoresRHeight(4,3)/100,'140','Color','r')
% text(scoresRHeight(5,1)/90,scoresRHeight(5,2)/92,scoresRHeight(5,3)/100,'151','Color','r')
% 
xlabel(['Principal Component 1 (' num2str(explainedRHeight(1),'%.1f') '%)']) 
ylabel(['Principal Component 2 (' num2str(explainedRHeight(2),'%.1f') '%)']) 
% zlabel(['Principal Component 3 (' num2str(explainedRHeight(3),'%.1f') '%)'])
% 

%% HRatio
% HRatio1_idx = find(Data(:,31)<41);
% HRatioAttr1 = Data(HRatio1_idx,7:29);
% HRatio1=[labels;HRatioAttr1];
% 
% HRatio2_idx = find(Data(:,31)>40 & Data(:,31)<51.6);
% HRatioAttr2 = Data(HRatio2_idx,7:29);
% HRatio2=[labels;HRatioAttr2];
% 
% HRatio3_idx = find(Data(:,31)>51.5);
% HRatioAttr3 = Data(HRatio2_idx,7:29);
% HRatio3=[labels;HRatioAttr3];
% 
% meanHRatio1 = nanmean(HRatio1);
% meanHRatio2 = nanmean(HRatio2);
% meanHRatio3 = nanmean(HRatio3);
% inputHRatio=[meanHRatio1;meanHRatio2;meanHRatio3];
% 
% [coefsHRatio,scoresHRatio,variancesHRatio,tstatHRatio,explainedHRatio] = pca(inputHRatio); 
% 
% figure;screeHRatio = plot(0:2,[0,explainedHRatio(1),sum(explainedHRatio(1:2))]);
%   title('Scree-HRatio')
%   xlabel('Principal Components');
%   ylabel('Variance Explained [%]')
%   hold on 
%   bar(1:2,explainedHRatio, 'b');
%   ylim([0 100]);
%   hold off
% 
% 
% figure;scoresHRatioPlot = plot(scoresHRatio(:,1),scoresHRatio(:,2),'*'); 
% title('Scores-HRatio')
% xlabel(['Principal Component 1 (' num2str(explainedHRatio(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedHRatio(2),'%.1f') '%)']) 
% text(scoresHRatio(1,1),scoresHRatio(1,2),'Lav') 
% text(scoresHRatio(2,1),scoresHRatio(2,2),'Mellem')
% text(scoresHRatio(3,1),scoresHRatio(3,2),'Høj') 
% 
% figure;biplot(coefsHRatio(:,1:2),'Scores', scoresHRatio(:,1:2),'varlabels',varlabels,'markersize', 10);
% title('Biplot-HRatio')
% text(scoresHRatio(1,1)/59.18,scoresHRatio(1,2)/59.18,'Lav','Color','r') 
% text(scoresHRatio(2,1)/59.18,scoresHRatio(2,2)/59.18,'Mellem','Color','r')
% text(scoresHRatio(3,1)/59.18,scoresHRatio(3,2)/59.18,'Høj','Color','r') 
% 
% xlabel(['Principal Component 1 (' num2str(explainedHRatio(1),'%.1f') '%)']) 
% ylabel(['Principal Component 2 (' num2str(explainedHRatio(2),'%.1f') '%)']) 
% 

%% The plotmachine
% Work in progress

% Add funcitons to initialise plots

%% Take out the trash

% Define which variables you want to keep in the workspace

clearvars -except Data