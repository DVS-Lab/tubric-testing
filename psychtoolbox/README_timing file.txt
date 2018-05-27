TUBRIC sequence testing - fMRI timing files	

-Reward(for each subject): phase/variable_(_c)_run_(n run)_blk_(n blk).txt

	- phase/variable: choice, prob and feedback have parametric and constant terms(_c)
		-choice: decision phase, E(chosen S) modulating choice-onset
		-prob: decision phase, P(chosen S) modulating choice-onset
		-feedback: outcome phase, prediction error modulating outcome-onset
		-lapse: lapse trials
	- _c: if non-parametric regressors, then _c
	- n run: number of runs
	- n blk: number of blocks


-MID(for each subject/run): 
	-high(or low)_run_(n run).txt
		-high or low cue modulating cue onset
	-high(or low)_hit(or miss)_run(n run).txt
		-high or low cue and hit or miss outcomes, modulating outcome onset
	
-finger(for each subject/run): left(or right).txt