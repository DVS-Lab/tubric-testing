s = dir(sub_dir);
n_run = sum([s(~ismember({s.name},{'.','..'})).isdir]);

for r = 1:n_run

    clear left right dur c

    run_dir = fullfile(sub_dir, num2str(r));
    load(fullfile(run_dir,sprintf('%s_finger.mat',num2str(r))))

    ntrials = 2*length(data);
    dur = duration*ones(ntrials,1);
    c   = constant*ones(ntrials,1);

    for i = 1:length(data)
       left(i) = data(i).left_onset;
       right(i) = data(i).right_onset;
    end
    
    temp = zeros(ntrials,1);
    temp(1:length(left)) = 1;
    ix_left  = temp;
    ix_right = c - ix_left;
    onset    = [left';right'];    
    resp = [onset, dur, ix_left, ix_right];

	cd(outputdir);
	
	filename = sprintf('sub-%s_task-finger_run-0%d.tsv',sub_name,r);
	headers = {'onset', 'dur', 'left', 'right'};
	headers = sprintf('%s\t',headers{:});
	headers(end) = '';
	dlmwrite(filename, headers,'')
	dlmwrite(filename, resp, '-append','delimiter','\t','precision','%.5f')
	
	cd(maindir);

end
