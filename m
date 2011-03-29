From: manuel_roeder@gmx.de (Manuel Roeder)
Date: Tue, 29 Mar 2011 06:52:19 -0000
Subject: D-Link DNS323 Rev. B1 Problem with Kernel 2.6.38.1 (2.6.38, too)
	- I2C-Bus mv64xxx / RTC ST M41T80 / LM75 Sensor
Message-ID: <4D91803E.60601@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The formerly found bug seems to be introduced with the RTC-rework starting with kernel 2.6.38.
It seems to be NOT a bug of I2C- or LM75-driver! 
The bug starts with kernel 2.6.38 and is still there in 2.6.38.2.

Kernel 2.6.37.6 runs fine!!!! No RTC-bug here!!!

[   18.270364] i2c /dev entries driver
[   18.274728] rtc-m41t80 0-0068: chip found, driver version 0.05
[   18.280955] m41t80: dev (254:0)
[   18.281012] rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
[   20.280626] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   20.287144] rtc-m41t80 0-0068: Can't clear HT bit
[   20.292139] rtc-m41t80: probe of 0-0068 failed with error -5
[   22.290615] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   22.297153] lm75: probe of 0-0048 failed with error -110
[   24.300623] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   26.300925] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   28.300905] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   30.300636] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   32.300906] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   34.300844] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[   36.300648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0

regards Manuel Roeder - manuel.roeder(at)web.de
