s = dir(sub_dir);
n_blk = 4; % there are two .mat files for practice run

for r = 1:n_blk
    
    load(fullfile(sub_dir,sprintf('output_%d.mat',r)))
    outcome = output.outcome;
    ntrials = length(outcome);
    
    cue     = output.trial_starts;
    cue_dur = ones(ntrials,1);
    target  = output.target_starts;
    RT      = output.RT;
    cond    = output.condition;
    constant = ones(ntrials,1);
    duration = constant;
   
    cue  = [cue', duration, constant];
    resp = [target'+RT', duration, constant];
    
    high = find(cond==1);
    low  = find(cond==2);
    hit = find(outcome == 1);
    miss = find(outcome == 0);
    
    r_high_hit  = intersect(high,hit);
    r_high_miss = intersect(high,miss);
    r_low_hit   = intersect(low,hit);
    r_low_miss  = intersect(low,miss);
    
    high      = cue(high,:); 
    low       = cue(low,:);
    high_hit  = resp(r_high_hit,:);
    high_miss = resp(r_high_miss,:);
    low_hit   = resp(r_low_hit,:);
    low_miss  = resp(r_low_miss,:);
    
    cd(out_dir);
    mkdir(out_dir, num2str(r));
    run_file = fullfile(out_dir, num2str(r));
    cd(run_file);
    dlmwrite(sprintf('high_run_%d.txt',r),high,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('low_run_%d.txt',r),low,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('high_hit_run_%d.txt',r),high_hit,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('high_miss_run_%d.txt',r),high_miss,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('low_hit_run_%d.txt',r),low_hit,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('low_miss_run_%d.txt',r),low_miss,'delimiter','\t','precision','%.6f')
    cd(maindir);
end