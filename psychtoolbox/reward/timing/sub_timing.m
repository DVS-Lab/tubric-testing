s = dir(sub_dir);
n_run = sum([s(~ismember({s.name},{'.','..'})).isdir]);

for r = 1:n_run

    run_dir = fullfile(sub_dir, num2str(r));
	n_blk = length(dir([run_dir '/*.mat']));
	
	for b = 1:n_blk

            load(fullfile(run_dir,sprintf('%d_reward_%d.mat',r,b)))
            choicedata = transpose([data.feedback; data.deckchoice]);
            ntrials = length(data);

            % estimate learning
            data_fit.out = choicedata(:,1);
            data_fit.dec = choicedata(:,2);

            fit_RW;
            [v_c, v_uc, p, pe, ~] = RW( results.x, data_fit );

            lapse    = zeros(ntrials,3);
            choice   = lapse;
            feedback = lapse;
            prob     = lapse;

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
            indx = ~choice(:,1);
            
            choice(indx,:)   = [];
            prob(indx,:)     = [];
            feedback(indx,:) = [];

            % demean parametric regressors
            choice(:,3)   = choice(:,3) - mean(choice(:,3));
            prob(:,3)     = prob(:,3) - mean(prob(:,3));
            feedback(:,3) = feedback(:,3) - mean(feedback(:,3));

            len = size(choice, 1);
            constant = ones(len,1);

            choice_c    = [choice(:,1:2), constant];
            prob_c = [prob(:,1:2), constant];
            feedback_c = [feedback(:,1:2), constant];

            cd(out_dir);
            dlmwrite(sprintf('choice_run_%d_blk_%d.txt',r,b),choice,'delimiter','\t','precision','%.6f')
            dlmwrite(sprintf('choice_c_run_%d_blk_%d.txt',r,b),choice_c,'delimiter','\t','precision','%.6f')
            dlmwrite(sprintf('prob_run_%d_blk_%d.txt',r,b),prob,'delimiter','\t','precision','%.6f')
            dlmwrite(sprintf('prob_c_run_%d_blk_%d.txt',r,b),prob_c,'delimiter','\t','precision','%.6f')
            dlmwrite(sprintf('feedback_run_%d_blk_%d.txt',r,b),feedback,'delimiter','\t','precision','%.6f')
            dlmwrite(sprintf('feedback_c_run_%d_blk_%d.txt',r,b),feedback_c,'delimiter','\t','precision','%.6f')
            dlmwrite(sprintf('lapse_run_%d_blk_%d.txt',r,b),lapse,'delimiter','\t','precision','%.6f')
            cd(maindir);
			
		end

end
