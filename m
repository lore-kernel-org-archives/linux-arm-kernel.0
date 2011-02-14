From: prakity@marvell.com (Philip Rakity)
Date: Sun, 13 Feb 2011 22:54:57 -0800
Subject: [PATCH 0/2] arm: mach-mmp/plat-pxa: define sd private clock
	registers and use them
Message-ID: <0DCB3728-C0FD-4BD7-99BF-FFB074311075@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH 0/2] arm: mach-mmp/plat-pxa: define sd private clock
registers and use them.

Patch set 3/12

[PATCH 1/2] plat-pxa: Enable ability to adjust SD/MMC clocks
The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
clock.  This feature is useful and required depending on the board
design.  Add infrastructure to support SD clock tuning.

[PATCH 2/2] mach-mmp: Support for SD/MMC clock adjustment in brownstone
Set timing for brownstone for SD/MMC cards to enable detection
timing adjustments are needed when speed > 25MHz
remove limitation on maximum speed of 25MHz
