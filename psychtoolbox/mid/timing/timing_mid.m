%% specify subject name and output 3-column timing file
maindir = pwd;
datadir = fullfile(maindir,'data');
temp    = dir(datadir);
temp = temp([temp.isdir]');
subjects = temp(~ismember({temp.name},{'.','..'}));
num_sub = size(subjects,1);

outputdir = fullfile(maindir,'mid_bids');
if ~exist(outputdir,'dir')
    mkdir(outputdir);
end

duration = 20;
constant = 1;

for s = 1:num_sub

    sub_name = subjects(s).name;
    sub_dir  = fullfile(datadir,sub_name);

    sub_timing_mid;

end