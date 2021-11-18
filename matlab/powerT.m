% EF 230 RVR function powerT
% hacklab 3
% Autumn Mitchell, Daniel Leyva Zavala, Garison Howard, Jace Sebring, Stephen Qiu, Will Eriksson
% Created: October 28, 2021

function powerT(rover)
% Purpose : move the rover in the path of the power T
% Inputs: rover variable
% Output: none
% Usage: powerT(rover)
% Author: Jace Sebring
rover.resetHeading
for i = 0:1

    rover.setDriveSpeed(80)
    leave = getdata(rover,1.5)
    if leave
        return
    end
    rover.turnAngle(-90)
    pause(1)

    rover.setDriveSpeed(80)
    leave = getdata(rover,0.5)
    if leave
        return
    end
    rover.turnAngle(90)
    pause(1)

    rover.setDriveSpeed(80)
    leave = getdata(rover,0.5)
    if leave
        return
    end
    rover.turnAngle(90)
    pause(1)

    rover.setDriveSpeed(80)
    leave = getdata(rover,1.5)
    if leave
        return
    end
    rover.turnAngle(90)
    pause(1)

    rover.setDriveSpeed(80)
    leave = getdata(rover,0.5)
    if leave
        return
    end
    rover.turnAngle(90)
    pause(1)

    rover.setDriveSpeed(80)
    leave = getdata(rover,0.5)
    if leave
        return
    end
    rover.turnAngle(-90)
    pause(1)

    rover.setDriveSpeed(80)
    leave = getdata(rover,1.5)
    if leave
        return
    end
    rover.turnAngle(90)
    pause(1)

    rover.setDriveSpeed(80)
    leave = getdata(rover,0.5)
    if leave
        return
    end
    rover.turnAngle(90)
    pause(1)

end
end

function leave = getdata(rover,tin)
% Purpose : to read in ambient light data when the robot moves
% Inputs: rover variable, time
% Output: bool of whether then detected color is found
% Usage: leave = getdata(rover, 2)
% Author: Stephen Qiu

timer = tic()
while toc(timer)<tin
    color = getDetectedColor(rover)
    pause(0.1)
    if color.R >= 200 && color.G < 100 && color.B < 100
        leave = true
        rover.stop    % stops robot if color is detected
        return
    end
end
leave = false
end