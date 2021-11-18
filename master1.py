# EF 230 Python Rvr Project
# Stephen Qiu, Will Eriksson, Brandon Meadows
# Created: November 12, 2021

# Problem Description:
# Write a pyhton code for the rovers

# Solution Method:
# created two functions, one to detect distance, one to flash the lights on the rover, and combined them to work together

import os
import sys
sys.path.append('/home/pi/sphero-sdk-raspberrypi-python/')

import time
import qwiic_vl53l1x
import qwiic
import qwiic_micro_oled

from sphero_sdk import SpheroRvrObserver
from sphero_sdk import SerialAsyncDal
from sphero_sdk import RvrLedGroups
from sphero_sdk import Colors
from sphero_sdk import SpheroRvrAsync
from sphero_sdk import RawMotorModesEnum
from sphero_sdk import DriveFlagsBitmask


rvr = SpheroRvrObserver()

# this funtion reads in data from the tof sensor and will stop the loop when a distance of below 150 mm is detected
# code from in class example
def distance_sensor():
	ToF = qwiic.QwiicVL53L1X()
	ToF.sensor_init()

	myOLED = qwiic_micro_oled.QwiicMicroOled()
	myOLED.begin()
	myOLED.clear(myOLED.PAGE)
	myOLED.clear(myOLED.ALL)  # Clear display
	myOLED.set_font_type(0)
	myOLED.set_cursor(0, 0)
	myOLED.print("Vol RVR")
	myOLED.set_cursor(0, 15)
	myOLED.print("Dist(mm)")
	myOLED.display()
	No_Wall = 1
	speed = 0

	if(ToF.sensor_init() == None):
		print("Sensor online\n")
		while No_Wall == 1:
			rvr.reset_yaw()           # drives the rvr
			rvr.raw_motors(
				left_mode=RawMotorModesEnum.forward.value,
				left_speed = 80,
				right_mode=RawMotorModesEnum.forward.value,
				right_speed= 80
			)

			ToF.start_ranging()
			time.sleep(.005)  
			distance = ToF.get_distance()  # Get the result of the measurement
			time.sleep(.005)  
			ToF.stop_ranging()
			distI = distance / 25.4
			print("Distance(mm): %s Distance(in): %s" % (distance, distI))
			myOLED.set_cursor(0, 30)
			myOLED.print("       ")
			myOLED.display()
			myOLED.print(distance)
			myOLED.display()
			if distance <= 400:
				rvr.drive_with_heading(speed=0, heading =0, flags=0)   # stops when distance limit is reached
				No_Wall = 0
				break


def blink_lights(turn):
    """ This program demonstrates how to set multiple LEDs on RVR using the LED control helper. Code grabbed from Sphero documentation website
    """

    try:

        rvr.led_control.turn_leds_off()

        # Delay to show LEDs change
        time.sleep(1)

        for i in range(4):
            rvr.led_control.turn_leds_off()
            if turn == "r":

                rvr.led_control.set_multiple_leds_with_rgb(      # declares the lights wanted
                    leds=[
                        RvrLedGroups.headlight_right,
                        RvrLedGroups.brakelight_right,
                        RvrLedGroups.power_button_rear,
                        RvrLedGroups.power_button_front
                    ],
                    colors=[                                    # declares the colors wanted
                        255, 0, 0,
                        255, 0, 0,
                        255, 0, 0,
                        255, 0, 0,
                    ]
                )
            else:
                rvr.led_control.set_multiple_leds_with_rgb(
                    leds=[
                        RvrLedGroups.headlight_left,
                	    RvrLedGroups.brakelight_left,
                	    RvrLedGroups.battery_door_rear,
                	    RvrLedGroups.battery_door_front
                         ],
                    colors=[
                        255, 0, 0,
                        255, 0, 0,
                	    255, 0, 0,
                	    255, 0, 0,
                        ]
                )
            # Delay to show LEDs change
            time.sleep(0.1)
        
        rvr.led_control.turn_leds_off()
    except KeyboardInterrupt:
        print('\nProgram terminated with keyboard interrupt.')

def main():
    rvr.wake()

    time.sleep(2)   # wakes the rvr up

    print("\nReady to Roll\n")\

    turn = "a"

    while True:     # enters loop where the functions will be called until user exits

        distance_sensor()

        turn = input("\nWall detected, press 'l' to turn left or 'r' to turn right\n")

        while turn!="l" and turn!="r" :         # error checks input
            turn = input("Invalid Input, Please Try Again\n")

        blink_lights(turn)

        if turn == 'l':                   # Turns the rvr in the direction inputed, code used from sphero doc website
            rvr.drive_control.turn_left_degrees(
		        heading = 0,
		        amount=90
            )

            # Delay to allow RVR to drive
            time.sleep(0.001)
        else :
            rvr.drive_control.turn_right_degrees(
		        heading = 0,
		        amount = 90
		)

            # Delay to allow RVR to drive
            time.sleep(0.001)

main()
rvr.close()
