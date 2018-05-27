%% specify subject name and output 3-column timing file
maindir = pwd;
datadir = fullfile(maindir,'data');
temp    = dir(datadir);
temp = temp([temp.isdir]');
subjects = temp(~ismember({temp.name},{'.','..'}));
num_sub = size(subjects);

outputdir = fullfile(maindir,'evfiles_mid');
if ~exist(outputdir,'dir')
    mkdir(outputdir);
end

for s = 1:num_sub

    sub_name = subjects(s).name;
    sub_dir  = fullfile(datadir,sub_name);
    mkdir(outputdir,sub_name);
    out_dir = fullfile(outputdir,sub_name);

    sub_timing;

end
