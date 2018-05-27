s = dir(sub_dir);
n_run = sum([s(~ismember({s.name},{'.','..'})).isdir]);

for r = 1:n_run

    clear left right dur c

    run_dir = fullfile(sub_dir, num2str(r));
    load(fullfile(run_dir,sprintf('%s_finger.mat',num2str(r))))

    ntrials = length(data);
    dur = duration*ones(ntrials,1);
    c = constant*ones(ntrials,1);

    for i = 1:ntrials
       left(i) = data(i).left_onset;
       right(i) = data(i).right_onset;
    end
    %make empty mats (for *_par, will make *_con last)
    left = [left', dur, c];
    right = [right', dur, c];

    cd(out_dir);
    mkdir(out_dir, num2str(r));
    run_file = fullfile(out_dir, num2str(r));
    cd(run_file);
    dlmwrite(sprintf('left%d.txt'),left,'delimiter','\t','precision','%.6f')
    dlmwrite(sprintf('right%d.txt'),right,'delimiter','\t','precision','%.6f')
    cd(maindir);

end
