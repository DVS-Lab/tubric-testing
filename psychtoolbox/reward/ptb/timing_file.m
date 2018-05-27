subject = 1;
maindir = pwd;
datadir = fullfile(maindir,'data',num2str(subject));
outputdir = fullfile(maindir,'evfiles',num2str(subject));
if ~exist(outputdir,'dir')
    mkdir(outputdir);
end

blocks = 1:2;
for r = 1:length(blocks)

    load(fullfile(datadir,sprintf('%s_feedback_%d.mat',num2str(subject),r))) % '%s_reward_%d.mat'
    choicedata = transpose([data.feedback; data.deckchoice]);
    ntrials = length(data);

    % estimate learning
    data_fit.out = choicedata(:,1);
    data_fit.dec = choicedata(:,2);

    fit_RW;
    [v_c, v_uc, p, pe, ~] = RW( results.x, data_fit );

    lapse   = zeros(ntrials,3);
    choice   = lapse1;
    feedback = choice;

    for t = 1:ntrials

        if data(t).lapse1
            lapse(t,1) = data(t).choice_onset;
            lapse(t,2) = 2.5;
            lapse(t,3) = 1;
        else
            choice(t,1) = data(t).choice_onset;
            choice(t,2) = data(t).RT1;
            choice(t,3) = v_c(t);

            prob(t,1) = data(t).choice_onset;
            prob(t,2) = data(t).RT1;
            prob(t,3) = p(t);

            feedback(t,1) = data(t).info_onset;
            feedback(t,2) = 1.75;
            feedback(t,3) = pe(t);

        end
    end

% remove lapse trials
choice(~choice(:,1),:)           = [];
prob(~prob(:,1),:) = [];
feedback(~feedback(:,1),:)       = [];

% demean parametric regressors
choice(:,3)      = choice(:,3) - mean(choice(:,3));
prob(:,3) = prob(:,3) - mean(prob(:,3));
feedback(:,3)    = feedback(:,3) - mean(feedback(:,3));

len = size(choice, 1);
constant = ones(len,1);

choice_c    = [choice(:,1:2), constant];
prob_c = [prob(:,1:2), constant];
feedback_c = [feedback(:,1:2), constant];

    cd(outputdir);
    dlmwrite(sprintf('choice_run_%d.txt',r),choice,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('choice_c_run_%d.txt',r),choice_c,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('prob_run_%d.txt',r),prob,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('prob_c_run_%d.txt',r),prob_c,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('feedback_run_%d.txt',r),feedback,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('feedback_c_run_%d.txt',r),feedback_c,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('lapse_run_%d.txt',r),lapse,'delimiter','\t','precision','%.6f')
    cd(maindir);
end
