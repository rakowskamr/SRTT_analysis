%% SRTT - error rate for left and right hand separately

% This script gets the error rate per block of the SRTT for 
% left and right hand separately. Separate result files are
% created for the reactivated and non-reactivated blocks and for
% each experimental session.

% Clear the workspace and the screen
sca;
close all;
clearvars;
clc
dbstop if error 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   MY SETTINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Directories
resultsFolder = 'yourDirectory/SRTT';
outputFolder_LeftRight = 'yourDirectory/Results';
SWS_subjects = dlmread('yourDirectory/SRTT/ALL_subjects.txt');


l_SWS = length(SWS_subjects);

% Ouptut file names
R_SWS_left_results = zeros(l_SWS,27);
R_SWS_right_results = zeros(l_SWS,27);
NR_SWS_left_results = zeros(l_SWS,27);
NR_SWS_right_results = zeros(l_SWS,27);


%% PRE-SLEEP ANALYSIS for SWS group

for pSWS = 1:l_SWS
    
    %load all data from all participants
    results_pre = sprintf('p%d_6-8w_Follow_up.mat', SWS_subjects(pSWS)); %<--- edit your input file name (here and at the end)
    results_pre = fullfile(resultsFolder,results_pre);
    results_pre = load(results_pre);
    
    % user choice (which sequence was first and which one was reactivated)
    results_pre_sequence_TMR = results_pre.params.userChoice;
    
    % which block was first
    if findstr(results_pre_sequence_TMR, 'sfA')
        sequence = 1; % sequence 1 is sequence A - means sequence A was first (follow fixedBlocksA)
    else sequence = 2; % sequence 2 is sequence B - means sequence B was first (follow fixedBlocksB)
    end
    
    blocks_order_A = results_pre.params.fixedBlocksA;
    blocks_order_B = results_pre.params.fixedBlocksB;
    
    if sequence == 1
        blocks_order = blocks_order_A;
    else if sequence == 2
            blocks_order = blocks_order_B;
        end
    end
    
    blocks_order = blocks_order';
    
    % which block was reactivated
    if findstr(results_pre_sequence_TMR, 'rA')
        TMR = 1; % TMR 1 means sequence A was reactivated
    else TMR = 2; % TMR 2 means sequence B was reactivated
    end
    
    % blocks = results from each block (total 52 before/after sleep)
    
    results_pre_blocks = results_pre.params.Block; % get all blocks
    b = length(blocks_order);
    blocks_A = blocks_order == 1;
    blocks_B = blocks_order == 2;
    blocks_randomA = blocks_order == 3;
    blocks_randomB = blocks_order == 4;
    
    results_blocks_A = results_pre_blocks(blocks_A); % get all blocks that have seq A
    b_A = length(results_blocks_A);
    results_blocks_B = results_pre_blocks(blocks_B); % get all blocks that have seq B
    b_B = length(results_blocks_B);
      
    results_blocks_randomA = results_pre_blocks(blocks_randomA); % get all blocks that have random A
    b_randomA = length(results_blocks_randomA);
    results_blocks_randomB = results_pre_blocks(blocks_randomB); % get all blocks that have random B
    b_randomB = length(results_blocks_randomB);
    
    % create table with RT and blocks
    % for left hand
    Lt_results_pre_blocks_A_RT = zeros(b_A,2);
    Lt_results_pre_blocks_A_RT(:,1) = 1:b_A;
    
    Lt_results_pre_blocks_B_RT = zeros(b_B,2);
    Lt_results_pre_blocks_B_RT(:,1) = 1:b_B;
    
    Lt_results_pre_blocks_randomA_RT = zeros(b_randomA,2);
    Lt_results_pre_blocks_randomA_RT(:,1) = 1:b_randomA;
    
    Lt_results_pre_blocks_randomB_RT = zeros(b_randomB,2);
    Lt_results_pre_blocks_randomB_RT(:,1) = 1:b_randomB;
    
    %for right hand
    Rt_results_pre_blocks_A_RT = zeros(b_A,2);
    Rt_results_pre_blocks_A_RT(:,1) = 1:b_A;
    
    Rt_results_pre_blocks_B_RT = zeros(b_B,2);
    Rt_results_pre_blocks_B_RT(:,1) = 1:b_B;
    
    Rt_results_pre_blocks_randomA_RT = zeros(b_randomA,2);
    Rt_results_pre_blocks_randomA_RT(:,1) = 1:b_randomA;
    
    Rt_results_pre_blocks_randomB_RT = zeros(b_randomB,2);
    Rt_results_pre_blocks_randomB_RT(:,1) = 1:b_randomB;
    
    % BLOCKS A and B
    for i = 1: b_A % get RT from all blocks that have seq A
    results_pre_blocks_A = results_blocks_A(i).exp_data;
    results_pre_blocks_A_RT = results_pre_blocks_A(:,4);
    L = results_pre_blocks_A(:,1) <= 2; 
    L_results_pre_blocks_A = results_pre_blocks_A_RT(L);
    %no_outliers = L_results_pre_blocks_A <= 1000
    %L_results_pre_blocks_A = L_results_pre_blocks_A(no_outliers)
    Lt_results_pre_blocks_A_RT(i,2) = sum(L_results_pre_blocks_A);
    R = results_pre_blocks_A(:,1) >= 3;
    R_results_pre_blocks_A = results_pre_blocks_A_RT(R);
    %no_outliers = R_results_pre_blocks_A <= 1000
    %R_results_pre_blocks_A = R_results_pre_blocks_A(no_outliers)
    Rt_results_pre_blocks_A_RT(i,2) = sum(R_results_pre_blocks_A);
    end
    
    for i = 1: b_B % get RT from all blocks that have seq 
    results_pre_blocks_B = results_blocks_B(i).exp_data;
    results_pre_blocks_B_RT = results_pre_blocks_B(:,4);
    L = results_pre_blocks_B(:,1) <= 2; 
    L_results_pre_blocks_B = results_pre_blocks_B_RT(L);
    %no_outliers = L_results_pre_blocks_B <= 1000
    %L_results_pre_blocks_B = L_results_pre_blocks_B(no_outliers)
    Lt_results_pre_blocks_B_RT(i,2) = sum(L_results_pre_blocks_B);
    R = results_pre_blocks_B(:,1) >= 3;
    R_results_pre_blocks_B = results_pre_blocks_B_RT(R);
    %no_outliers = R_results_pre_blocks_B <= 1000
    %R_results_pre_blocks_B = R_results_pre_blocks_B(no_outliers)
    Rt_results_pre_blocks_B_RT(i,2) = sum(R_results_pre_blocks_B);
    end
    
    %RANDOM BLOCKS
    for i = 1: b_randomA % get RT from all blocks that have random A
    results_pre_blocks_randomA = results_blocks_randomA(i).exp_data;
    results_pre_blocks_randomA_RT = results_pre_blocks_randomA(:,4);
    L = results_pre_blocks_randomA(:,1) <= 2; 
    L_results_pre_blocks_randomA = results_pre_blocks_randomA_RT(L);
    %no_outliers = L_results_pre_blocks_randomA <= 1000
    %L_results_pre_blocks_randomA = L_results_pre_blocks_randomA(no_outliers)
    Lt_results_pre_blocks_randomA_RT(i,2) = sum(L_results_pre_blocks_randomA);
    R = results_pre_blocks_randomA(:,1) >= 3;
    R_results_pre_blocks_randomA = results_pre_blocks_randomA_RT(R);
    %no_outliers = R_results_pre_blocks_randomA <= 1000
    %R_results_pre_blocks_randomA = R_results_pre_blocks_randomA(no_outliers)
    Rt_results_pre_blocks_randomA_RT(i,2) = sum(R_results_pre_blocks_randomA);
    end

    for i = 1: b_randomB % get RT from all blocks that have random A
    results_pre_blocks_randomB = results_blocks_randomB(i).exp_data;
    results_pre_blocks_randomB_RT = results_pre_blocks_randomB(:,4);
    L = results_pre_blocks_randomB(:,1) <= 2; 
    L_results_pre_blocks_randomB = results_pre_blocks_randomB_RT(L);
    %no_outliers = L_results_pre_blocks_randomB <= 1000
    %L_results_pre_blocks_randomB = L_results_pre_blocks_randomB(no_outliers)
    Lt_results_pre_blocks_randomB_RT(i,2) = sum(L_results_pre_blocks_randomB);
    R = results_pre_blocks_randomB(:,1) >= 3;
    R_results_pre_blocks_randomB = results_pre_blocks_randomB_RT(R);
    %no_outliers = R_results_pre_blocks_randomB <= 1000
    %R_results_pre_blocks_randomB = R_results_pre_blocks_randomB(no_outliers)
    Rt_results_pre_blocks_randomB_RT(i,2) = sum(R_results_pre_blocks_randomB);
    end
   

  if TMR == 1 % if seq A was reactivated (R)
     
    % right hand   
    R_R_pre_all_blocks = Rt_results_pre_blocks_A_RT(:,2)'; 
    R_R_pre_all_random_blocks = Rt_results_pre_blocks_randomA_RT(:,2)';
    
    NR_R_pre_all_blocks = Rt_results_pre_blocks_B_RT(:,2)';
    NR_R_pre_all_random_blocks = Rt_results_pre_blocks_randomB_RT(:,2)';
    
    % left hand
    R_L_pre_all_blocks = Lt_results_pre_blocks_A_RT(:,2)'; 
    R_L_pre_all_random_blocks = Lt_results_pre_blocks_randomA_RT(:,2)';
    
    NR_L_pre_all_blocks = Lt_results_pre_blocks_B_RT(:,2)';
    NR_L_pre_all_random_blocks = Lt_results_pre_blocks_randomB_RT(:,2)';
    
    else if TMR == 2 % if seq B was reactivated (R)
   
    % right hand         
    R_R_pre_all_blocks = Rt_results_pre_blocks_B_RT(:,2)';
    R_R_pre_all_random_blocks = Rt_results_pre_blocks_randomB_RT(:,2)';
    
    NR_R_pre_all_blocks = Rt_results_pre_blocks_A_RT(:,2)';
    NR_R_pre_all_random_blocks = Rt_results_pre_blocks_randomA_RT(:,2)';
    
    % left hand
    R_L_pre_all_blocks = Lt_results_pre_blocks_B_RT(:,2)';
    R_L_pre_all_random_blocks = Lt_results_pre_blocks_randomB_RT(:,2)';
       
    NR_L_pre_all_blocks = Lt_results_pre_blocks_A_RT(:,2)';
    NR_L_pre_all_random_blocks = Lt_results_pre_blocks_randomA_RT(:,2)';
     
    
    else
            fprintf('error, dont know which sequence was TMRed');
        end
    end
    
    R_SWS_right_results(pSWS,:) = [pSWS R_R_pre_all_blocks R_R_pre_all_random_blocks]; 
    NR_SWS_right_results(pSWS,:) = [pSWS NR_R_pre_all_blocks NR_R_pre_all_random_blocks];

    R_SWS_left_results(pSWS,:)= [pSWS R_L_pre_all_blocks R_L_pre_all_random_blocks];
    NR_SWS_left_results(pSWS,:) = [pSWS NR_L_pre_all_blocks NR_L_pre_all_random_blocks];

end

R_SWS_right_results(:,1) = SWS_subjects;
NR_SWS_right_results(:,1) = SWS_subjects;
R_SWS_left_results(:,1) = SWS_subjects;
NR_SWS_left_results(:,1) = SWS_subjects;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         SAVE RESULTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filesave = sprintf('R_SWS_right_accuracy_6W.mat'); % <------- CHANGE THE NAME
filesave = fullfile(outputFolder_LeftRight,filesave);
save(filesave,'R_SWS_right_results');

filesave = sprintf('NR_SWS_right_accuracy_6W.mat');% <------- CHANGE THE NAME
filesave = fullfile(outputFolder_LeftRight,filesave);
save(filesave,'NR_SWS_right_results');

filesave = sprintf('R_SWS_left_accuracy_6W.mat');% <------- CHANGE THE NAME
filesave = fullfile(outputFolder_LeftRight,filesave);
save(filesave,'R_SWS_left_results');

filesave = sprintf('NR_SWS_left_accuracy_6W.mat');% <------- CHANGE THE NAME
filesave = fullfile(outputFolder_LeftRight,filesave);
save(filesave,'NR_SWS_left_results');

