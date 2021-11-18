% EF 230 RVR function snake_path
% hacklab 3
% Autumn Mitchell, Daniel Leyva Zavala, Garison Howard, Jace Sebring, Stephen Qiu, Will Eriksson
% Created: October 31, 2021

function found = snake_path(rover, color)
% Purpose : move the rover in a snaking path
% Inputs: rover variable, color the user wants the rover to detect,
% color menu in integrated code
% Output: bool of whether color was detected
% Usage: found = snake_path(rover, 1) 
% Author: Stephen Qiu

rover.setDriveSpeed(80)
leave = getdata(rover, 2, color)
if leave
    found = true
    return
end
rover.turnAngle(95)
pause(1)

rover.setDriveSpeed(50)
leave = getdata(rover, 0.5, color)
if leave
    found = true
    return
end
rover.turnAngle(95)
pause(1)

rover.setDriveSpeed(80)
leave = getdata(rover, 2, color)
if leave
    found = true
    return
end
rover.turnAngle(-95)
pause(1)

rover.setDriveSpeed(50)
leave = getdata(rover, 0.5, color)
if leave
    found = true
    return
end
rover.turnAngle(-95)
pause(1)
found = false
end


function leave = getdata(rover, tin, color)
% Purpose : to read in ambient light data when the robot moves
% Inputs: rover variable, time, color wated to find
% Output: bool of whether then detected color is found
% Usage: leave = getdata(rover, 2, 1)
% Author: Garrison Howard/ Stephen Qiu

% red_lower_bound = color_matrix(color,1)
% green_lower_bound = color_matrix(color,2)
% blue_lower_bound = color_matrix(color,3)

% sets the values of the desired colors lower bound, add 50 to get upper bound

if color==1
    Lower.R=205
    Lower.G=0
    Lower.B=0   
elseif color==2
    Lower.R=205
    Lower.G=110
    Lower.B=25
elseif color==3
    Lower.R=205
    Lower.G=200
    Lower.B=30
elseif color==4
    Lower.R=0
    Lower.G=120
    Lower.B=100
elseif color==5
    Lower.R=0
    Lower.G=150
    Lower.B=200
elseif color==6
    Lower.R= 20
    Lower.G= 10
    Lower.B= 80
end

% sets upper color bounds
Top.R=Lower.R+50
Top.G=Lower.G+50
Top.B=Lower.B+50

timer = tic()
while toc(timer)<tin
    color = getDetectedColor(rover)
    pause(0.1)

    if color.R>=Lower.R && color.G>=Lower.G && ...
            color.B>=Lower.B && color.R<=Top.R && ...
            color.G<=Top.G && color.B<=Top.B
        leave = true    % stops the robot if color is detected      
        rover.stop
        return
    end
    
end
leave = false
end
