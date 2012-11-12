From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2012 09:33:29 +0000
Subject: Build failure: OMAP4430 failed due to exynos4 pinctrl
Message-ID: <20121112093329.GC28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last night's randconfig for OMAP4430 failed with:

drivers/built-in.o:(.rodata+0x1a60): undefined reference to `exynos4210_pin_ctrl'

Config and log:
http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2693
http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2693
