s = dir(sub_dir);
n_run = sum([s(~ismember({s.name},{'.','..'})).isdir]);
blk_t = 36;
run_ix = 0;

for r = 1:n_run

    run_dir = fullfile(sub_dir, num2str(r));
	n_blk = length(dir([run_dir '/*.mat']));
    
    choicedata = [];
    
    for b = 1:n_blk
        load(fullfile(run_dir,sprintf('%d_reward_%d.mat',r,b)))
        temp = transpose([data.feedback; data.deckchoice]);
        choicedata = [choicedata; temp];
    end
    
    data_fit.out = choicedata(:,1);
    data_fit.dec = choicedata(:,2);

    fit_RW;
    [v_c, v_uc, p, pe, ~] = RW( results.x, data_fit );
	
	for b = 1:n_blk
            
            run_ix = run_ix + 1;

            load(fullfile(run_dir,sprintf('%d_reward_%d.mat',r,b)))
            ntrials = length(data);

            indx = ((b-1)*blk_t + 1):((b-1)*blk_t + blk_t);
            ev   = v_c(indx);
            prob = p(indx);
            rpe  = pe(indx);
            
            ev   = ev - mean(ev);
            prob = prob - mean(prob);
            rpe  = rpe - mean(rpe); 
                        
            info_dur = 1.75;
            
            onset    = [[data.choice_onset]'; [data.info_onset]'];
            dur      = [[data.RT1]'; info_dur * ones(blk_t,1)];
            dec      = [ones(blk_t,1); zeros(blk_t,1)];
            out      = [zeros(blk_t,1); ones(blk_t,1)];
            ev       = [ev; zeros(blk_t,1)];
            prob     = [prob; zeros(blk_t,1)];
            rpe      = [zeros(blk_t,1); rpe];
            
            choice = [onset, dur, dec, out, ev, prob, rpe];
            lapse  = isnan([data.feedback]');
            choice(lapse,:) = [];         

            cd(outputdir);
            
            filename = sprintf('sub-%s_task-reward_run-0%d.tsv',sub_name,run_ix);
            headers = {'onset', 'dur', 'dec', 'out', 'ev', 'lik', 'rpe'};
            headers = sprintf('%s\t',headers{:});
            headers(end) = '';
            dlmwrite(filename, headers,'')
            dlmwrite(filename, choice, '-append','delimiter','\t','precision','%.5f')
            
            old = fileread(filename);
            new = strrep(old, 'NaN', 'n/a');
            dlmwrite(filename,new,'');
            
            cd(maindir);
			
		end

end
