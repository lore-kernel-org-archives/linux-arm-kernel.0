From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 21:06:40 +0000
Subject: [GIT PULL 3/5] First set of omap1 related changes
In-Reply-To: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de>
References: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de>
Message-ID: <201202292106.40731.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Tony Lindgren wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1
> 
> Janusz Krzysztofik (7):
>       ARM: OMAP1: ams-delta: register latch dependent devices later
>       ARM: OMAP1: ams-delta: convert latches to basic_mmio_gpio
>       ARM: OMAP1: ams-delta: supersede custom led device by leds-gpio
>       LED: drop leds-ams-delta driver
>       MTD: NAND: ams-delta: use GPIO instead of custom I/O
>       omapfb: lcd_ams_delta: drive control lines over GPIO
>       input: serio: ams-delta: toggle keyboard power over GPIO
> 

Since these are all for ams-delta, I pulled them into next/boards together
with other board specific updates.

Thanks,

	Arnd
