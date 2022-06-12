%% SRTT - reaction time for both hands

% This script gets the reaction time per block of the SRTT. Separate result
% files are created for the reactivated and non-reactivated blocks and for
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

R_SWS_results = zeros(l_SWS,27);
NR_SWS_results = zeros(l_SWS,27);

% Ouptut file names
name_R = 'R_S1_results.mat'; % <----- CHANGE THE NAME (session)
name_NR = 'NR_S1_results.mat'; % <----- CHANGE THE NAME (session)

%% PRE-SLEEP ANALYSIS 

for pSWS = 1:l_SWS
    
    %load all data from all participants
    results = sprintf('p%d_Learn.mat', SWS_subjects(pSWS)); %<----- edit your input file name
    results = fullfile(resultsFolder,results);
    results = load(results);
    
    % user choice (which sequence was first and which one was reactivated)
    results_sequence_TMR = results.params.userChoice;
    
    % which block was first
    if findstr(results_sequence_TMR, 'sfA')
        sequence = 1; % sequence 1 is sequence A - means sequence A was first (follow fixedBlocksA)
    else sequence = 2; % sequence 2 is sequence B - means sequence B was first (follow fixedBlocksB)
    end
    
    blocks_order_A = results.params.fixedBlocksA;
    blocks_order_B = results.params.fixedBlocksB;
    
    if sequence == 1
        blocks_order = blocks_order_A;
    else
        if sequence == 2
            blocks_order = blocks_order_B;
        end
    end
    
    blocks_order = blocks_order';
    
    % which block was reactivated
    if findstr(results_sequence_TMR, 'rA')
        TMR = 1; % TMR 1 means sequence A was reactivated
    else TMR = 2; % TMR 2 means sequence B was reactivated
    end
    
    % blocks = results from each block (total 52 before/after sleep)
    
    results_blocks = results.params.Block; % get all blocks
    b = length(blocks_order);
    blocks_A = blocks_order == 1;
    blocks_B = blocks_order == 2;
    blocks_randomA = blocks_order == 3;
    blocks_randomB = blocks_order == 4;
    
    results_blocks_A = results_blocks(blocks_A); % get all blocks that have seq A
    b_A = length(results_blocks_A);
    results_blocks_B = results_blocks(blocks_B); % get all blocks that have seq B
    b_B = length(results_blocks_B);
      
    results_blocks_randomA = results_blocks(blocks_randomA); % get all blocks that have random A
    b_randomA = length(results_blocks_randomA);
    results_blocks_randomB = results_blocks(blocks_randomB); % get all blocks that have random B
    b_randomB = length(results_blocks_randomB);
    
    % create table with RT and blocks
    t_results_blocks_A_RT = zeros(b_A,2);
    t_results_blocks_A_RT(:,1) = 1:b_A;
    
    t_results_blocks_B_RT = zeros(b_B,2);
    t_results_blocks_B_RT(:,1) = 1:b_B;
    
    t_results_blocks_randomA_RT = zeros(b_randomA,2);
    t_results_blocks_randomA_RT(:,1) = 1:b_randomA;
    
    t_results_blocks_randomB_RT = zeros(b_randomB,2);
    t_results_blocks_randomB_RT(:,1) = 1:b_randomB;
    
    % BLOCKS A and B
    for i = 1:b_A % get RT from all blocks that have seq A
    results_x_blocks_A = results_blocks_A(i).exp_data;
    results_x_blocks_A_RT = results_x_blocks_A(:,3);
    no_outliers = results_x_blocks_A_RT <= 1000;
    results_x_blocks_A_RT = results_x_blocks_A_RT(no_outliers);
    mean_results_blocks_A_RT = mean(results_x_blocks_A_RT);
    t_results_blocks_A_RT(i,2) = mean_results_blocks_A_RT;
    end
       
    for i = 1:b_B % get RT from all blocks that have seq B
    results_x_blocks_B = results_blocks_B(i).exp_data;
    results_x_blocks_B_RT = results_x_blocks_B(:,3);
    no_outliers = results_x_blocks_B_RT <= 1000;
    results_x_blocks_B_RT = results_x_blocks_B_RT(no_outliers);
    mean_results_blocks_B_RT = mean(results_x_blocks_B_RT);
    t_results_blocks_B_RT(i,2) = mean_results_blocks_B_RT;
    end
    
    %RANDOM BLOCKS
    for i = 1:b_randomA % get RT from all blocks that have random A
    results_x_blocks_randomA = results_blocks_randomA(i).exp_data;
    results_x_blocks_randomA_RT = results_x_blocks_randomA(:,3);
    no_outliers = results_x_blocks_randomA_RT <= 1000;
    results_x_blocks_randomA_RT = results_x_blocks_randomA_RT(no_outliers);
    mean_results_blocks_randomA_RT = mean(results_x_blocks_randomA_RT);
    t_results_blocks_randomA_RT(i,2) = mean_results_blocks_randomA_RT;
    end

    for i = 1:b_randomB % get RT from all blocks that have random A
    results_x_blocks_randomB = results_blocks_randomB(i).exp_data;
    results_x_blocks_randomB_RT = results_x_blocks_randomB(:,3);
     no_outliers = results_x_blocks_randomB_RT <= 1000;
    results_x_blocks_randomB_RT = results_x_blocks_randomB_RT(no_outliers);
    mean_results_blocks_randomB_RT = mean(results_x_blocks_randomB_RT);
    t_results_blocks_randomB_RT(i,2) = mean_results_blocks_randomB_RT;
    end

     
    
    if TMR == 1 % if seq A was reactivated (R)
        
    R_all_blocks = t_results_blocks_A_RT(:,2)';
    R_all_random_blocks = t_results_blocks_randomA_RT(:,2)';
    
    NR_all_blocks = t_results_blocks_B_RT(:,2)';
    NR_all_random_blocks = t_results_blocks_randomB_RT(:,2)';
    
    else if TMR == 2 % if seq B was reactivated (R)
            
    R_all_blocks = t_results_blocks_B_RT(:,2)';
    R_all_random_blocks = t_results_blocks_randomB_RT(:,2)';
    
    NR_all_blocks = t_results_blocks_A_RT(:,2)';
    NR_all_random_blocks = t_results_blocks_randomA_RT(:,2)';
    else
            fprintf('error, dont know which sequence was TMRed');
        end
    end
    
    R_SWS_results(pSWS,:) = [pSWS R_all_blocks R_all_random_blocks]; 
    NR_SWS_results(pSWS,:) = [pSWS NR_all_blocks NR_all_random_blocks];

    
end

R_SWS_results(:,1) = SWS_subjects;
NR_SWS_results(:,1) = SWS_subjects;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         SAVE RESULTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filesave = sprintf(name_R);
filesave = fullfile(outputFolder_SWS,filesave);
save(filesave,'R_SWS_results');

filesave = sprintf(name_NR);
filesave = fullfile(outputFolder_SWS,filesave);
save(filesave, 'NR_SWS_results');



