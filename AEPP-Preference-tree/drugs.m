clear all
close all
clc

%Preference tree opgave
% Perceived health risk of drug
% N=48
rus=[
0 28 35 10 4 7
20 0 18 2 0 3
13 30 0 3 1 0
38 46 45 0 1 17
44 48 47 47 0 44
41 45 48 31 4 0];

%Rusmidler: 
%Alc Tob Can Ecs Her Coc


%laver en matrix, p_model, med "probabilities". Ifølge slideshowet fra mm8,
%regnes det ud, vha. freq/N, hvor freq er frequencies, og N er antallet af
%stimuli.
p_model = rus/48

%Definerer variabler til Weak Stochastic Transitivity, Moderate Stochastic
%Transitivity og Strong Stochastic Transitivity. Yderligere har jeg en
%counter, der tæller hvor mange gange, første if statement er sand. Med
%andre ord, hvor mange datapunkter, der ikke sammenlignes 
WST = 0;
MST = 0;
SST = 0;
Count = 0;

for a = 1:6;
    for b = 1:6;
        for c = 1:6;
            if (a~=b)&&(b~=c)&&(a~=c); %avoids comparing the same value (0)
                if p_model(a,b)>=0.5 && p_model(b,c) >=0.5;
                    Count = Count+1;
                    if p_model(a,c)<0.5; %checks for WST violations
                    WST = WST+1; %counts number of violations
                    end
                        if p_model(a,c) < min(p_model(a,b),p_model(b,c)); %checks for MST violations
                        MST = MST+1; %counts number of violations
                        end
                            if p_model(a,c) < max(p_model(a,b),p_model(b,c)); %checks for SST violations
                                SST = SST+1;%counts number of violations
                            end
                end
            end
        end
    end
end


%Vi undersøger først om BTL modellen passer.
%laver et cell-array på størrelse med antallet af søjler. 
A = {[1];[2];[3];[4];[5];[6]};


%Her regnes: p=parametre, chistat = chi squared test(output: X^2  frihedsgrader  p-værdi || tester goodness of fit)
%u = scale values (samme værdi i BLT som parametrene p), lL_eba/lL_sat = log
%likelihoods of model specified in A and of the saturated model, fit =
%returns the fitted values, covar = the covariance
%
%inputttet i fOptiPt er vores frequency, rus, og vores cell array, A
[p,chistat,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A);


%Her regnes 95% konfidensintervaller af diagonalen i vores covarians
conf_int= 1.96*sqrt(diag(cova));
%errorbar plotter figuren
errorbar(u,conf_int, 'O')
xlim([0 7]);
xlabel('Drug')
ylabel ('Estimated risk [95% CI]')


%Vi undersøger nu om preference-tree modellen passer.
%Vi har lavet forskellige pretree. 
A_tree13 = {[1];[2 8];[3 8];[4 7 8]; [5 7 8]; [6 7 8]};

[p_tree13,chistat_tree13,u13,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree13);

% 
%Vi undersøger nu om preference-tree modellen passer.
%Vi har lavet forskellige pretrees. 
A_tree15 = {[1];[2 9];[3 9];[4 7 8 9]; [5 7 8 9]; [6 8 9]};

[p_tree15,chistat_tree15,u15,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree15);


% %Her regnes 95% konfidensintervaller af diagonalen i vores covarians
% conf_int= 1.96*sqrt(diag(cova));
% %errorbar plotter figuren
% X=[1 2 3 4 5 6 7 8]
% errorbar(X,p_tree13,conf_int, 'O')
% xlim([0 8]);
% xlabel('Drug')
% ylabel ('Estimated risk [95% CI]')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       Nedenunder kommer pølsekode,                    %%%
%%%                  der udregner alle vores initierende gæt              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree = {[1 7];[2 7];[3 7];[4 8];[5 8];[6 8]};
% 
% 
% [p_tree,chistat_tree,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree);
% 
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree2 = {[1 7];[2 7];[3 8];[4 8];[5 8];[6 8]};
% 
% 
% [p_tree2,chistat_tree2,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree2);
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree3 = {[1];[2 7];[3 7];[4]; [5]; [6]};
% 
% [p_tree3,chistat_tree3,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree3);
% 
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree4 = {[1 8];[2 7 8];[3 7 8];[4 9]; [5 9]; [6 9]};
% 
% [p_tree4,chistat_tree4,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree4);
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree5 = {[1];[2 7];[3 7];[4 7]; [5 7]; [6 7]};
% 
% [p_tree5,chistat_tree5,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree5);
% 
 %Vi undersøger nu om preference-tree modellen passer.
 %Vi har lavet forskellige pretrees og tester nu det første. 
%  A_tree6 = {[1];[2 7 9];[3 7 9];[4 8 9]; [5 8 9]; [6 8 9]};
%  
%  [p_tree6,chistat_tree6,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree6);
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree7 = {[1];[2 7 8];[3 8];[4 7 8]; [5 7 8]; [6 7 8]};
% 
% % [p_tree7,chistat_tree7,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree7);
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree8 = {[1];[2];[3 7];[4 7]; [5 7]; [6 7]};
% 
% [p_tree8,chistat_tree8,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree8);


%Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree9 = {[1];[2];[3 7];[4 7]; [5]; [6 7]};
% 
% [p_tree9,chistat_tree9,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree9);
% 
% 
% 
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree10 = {[1];[2];[3];[4 7]; [5]; [6 7]};
% 
% [p_tree10,chistat_tree10,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree10);
% 
% 
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree11 = {[1];[2 8];[3 8];[4 7]; [5]; [6 7]};
% 
% [p_tree11,chistat_tree11,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree11);
% 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree12 = {[1];[2 7];[3 7];[4 8 9]; [5 9]; [6 8 9]};
% 
% [p_tree12,chistat_tree12,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree12);

%Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% A_tree14 = {[1];[2 7];[3 7];[4 7]; [5]; [6 7]};
% 
% [p_tree14,chistat_tree14,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree14);
% % 
% %Vi undersøger nu om preference-tree modellen passer.
% %Vi har lavet forskellige pretrees og tester nu det første. 
% % A_tree14 = {[1];[2 7];[3 7];[4 7]; [5]; [6 7]};
% % 
% % [p_tree14,chistat_tree14,u,lL_eba,lL_sat,fit,cova]=fOptiPt(rus,A_tree14);