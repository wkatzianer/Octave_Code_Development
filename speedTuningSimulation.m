close all; clear all; clc

pkg load 'communications'

speed_totem = 0;	% Input parameter
atb_per_tic = 0.07;	% Each monster gains 7% attack bar each clock cycle

% Assume Veromos is first on this list.
monster_base_speed = 100.* ones(5,1);	% all have the same base speed (for now)
monster_rune_speed = randi( [10, 130], 5, 1);  % random rune stats

boss_speed = 75;
crystal_speed = [100; 75];

total_speed = monster_base_speed .* (1 + speed_totem) + monster_rune_speed;

in_game_speed = [total_speed; boss_speed; crystal_speed] .* atb_per_tic;

simulationVector = in_game_speed;

iterations = 20;	% 20 run clock cycles

for count = 1:iterations
	simulationVector = simulationVector + in_game_speed;
	ind = find( simulationVector > 100);	% List all that broke 100% atb to sort who actually should move
	
	[m, n] = size(ind);
	if m >  0
	% pause here because this means at least one value passed 100
		fprintf ('Start of turn: %d\n', count);
		disp(simulationVector);
		[val, t] = sort(simulationVector, 'descend');
		simulationVector(t(1)) = 0;	% Monster moved, so reset 		attack bar
		fprintf ('At clock tic: %d, Monster %d took a turn\n', count, t(1));
		disp (simulationVector);
		keyboard;
	end 	
end