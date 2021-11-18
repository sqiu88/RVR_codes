% EF 230 Rover Project
% hacklab 3
% Autumn Mitchell, Daniel Leyva Zavala, Garison Howard, Jace Sebring, Stephen Qiu, Will Eriksson
% Created: October 28, 2021

% Problem Description:
% sample code that uses both our functions together


% Displays a menu asking the user to choose a color
choices = {'Red','Orange','Yellow','Green','Blue','Purple'}
color=menu({'Please pick a color you would like the rover to find.'},choices)

% runs the code for 20 seconds
tStart=tic;
while toc(tStart)<20
    found = snake_path(rover, color)
    if found                 
        powerT(rover)
        break
    end
end

if ~found
    disp("Color not found")
end

