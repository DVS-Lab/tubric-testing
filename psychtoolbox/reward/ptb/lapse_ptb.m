Screen('Flip', mywindow);
msg = 'Respond faster!';
Screen('TextStyle', mywindow, 0);
Screen('TextSize', mywindow, 40);
[normBoundsRect, ~] = Screen('TextBounds', mywindow, msg);
Screen('DrawText', mywindow, msg, (centerhoriz-(normBoundsRect(3)/2)), centervert, black);
Screen('Flip', mywindow);
press = 1;
choice = 0;
deckchoice = 0;
WaitSecs(.5);