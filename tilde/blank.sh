#!/bin/bash
./blinkbtled 0xd0018144 w 0x47BF7FFF > /dev/null  # enables our GPIOs
./blinkbtled 0xd0018014 w 0x01111111 > /dev/null  # enable GPIO 47
./blinkbtled 0xd0018020 w 0x0 > /dev/null         # set register to access 64
./blinkbtled 0xd0018184 w 0x2  > /dev/null        # enable 64
./blinkbtled 0xd0018180 w 0x1 > /dev/null         # turn on green eyes
./blinkbtled 0xd0018188 w 0x0 > /dev/null         # don't blink green eyes
./blinkbtled 0xd0018140 w 0x18400000 > /dev/null  # turn on green smile
