n_blk = 4; % there are two .mat files for practice run

for r = 1:n_blk
    
    load(fullfile(sub_dir,sprintf('output_%d.mat',r)))
    outcome = output.outcome;
    ntrials = length(outcome);
    
    cue     = output.trial_starts;
    dur     = ones(ntrials,1); % duration for cue and outcome displays are the same as 1s
    target  = output.target_starts;
    RT      = output.RT;
    cond    = output.condition;
    
    t = zeros(ntrials,1); ix_high = find(cond == 1); t(ix_high) = 1; high = t;
    t = zeros(ntrials,1); ix_low  = find(cond == 2); t(ix_low) = 1;  low  = t;
    t = zeros(ntrials,1); ix_hit = find(outcome == 1); t(ix_hit) = 1; hit = t;
    t = zeros(ntrials,1); ix_miss = find(outcome == 0); t(ix_miss) = 1; miss = t;
    
    t = zeros(ntrials,1); high_hit  = intersect(ix_high,ix_hit); t(high_hit) = 1; high_hit = t;
    t = zeros(ntrials,1); high_miss = intersect(ix_high,ix_miss); t(high_miss) = 1; high_miss = t;
    t = zeros(ntrials,1); low_hit   = intersect(ix_low,ix_hit); t(low_hit) = 1; low_hit = t;
    t = zeros(ntrials,1); low_miss  = intersect(ix_low,ix_miss); t(low_miss) = 1; low_miss = t;
    
    trial_ix = ones(ntrials,1);
    trial_nx = zeros(ntrials,1);
    mat = [high, low, hit, miss, high_hit, high_miss, low_hit, low_miss];
    cue = [cue', dur, trial_ix, trial_nx, mat]; 
    target = [target', dur, trial_nx, trial_ix, mat];
    resp = [cue; target];
    
	cd(outputdir);
	
	filename = sprintf('sub-%s_task-mid_run-0%d.tsv',sub_name,r);
	headers = {'onset', 'dur', 'cue', 'target','high', 'low', 'hit', 'miss', ...
		'high_hit', 'high_miss', 'low_hit', 'low_miss'};
	headers = sprintf('%s\t',headers{:});
	headers(end) = '';
	dlmwrite(filename, headers,'')
	dlmwrite(filename, resp, '-append','delimiter','\t','precision','%.5f')
    
	cd(maindir);
	
end