From: mwelling@ieee.org (Michael Welling)
Date: Thu, 25 Jun 2015 19:16:48 -0500
Subject: AT91 timer/counter as clock output from devicetree
Message-ID: <20150626001648.GA20565@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have run into situation with AT91 based products where I am at a
loss as to how to properly approproach implementing a driver/solution.

Several boards that I have dealt with are using the AT91's timer/counter pins
to emulate a simple clock output.

Currently, the only way I have found to emulate a clock output is to enable
the atmel,tcb-pwm driver and initialize the PWM from userspace using the
sysfs layer.

I would like to initialize the timer/counter in the kernel based on an entry
in the devicetree.

Does anyone have suggestion on how and where implement this?
