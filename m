From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 10 Oct 2016 17:08:10 +0300
Subject: MAINTAINERS entry for ARM/CLKDEV SUPPORT
Message-ID: <20161010140810.GA30609@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen Boyd,

The MAINTAINERS entry looks like this:

ARM/CLKDEV SUPPORT
M:      Russell King <linux@armlinux.org.uk>
L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      arch/arm/include/asm/clkdev.h
F:      drivers/clk/clkdev.c


We removed arch/arm/include/asm/clkdev.h in 34d2f4d3a4d6a6b ('ARM: Use
generic clkdev.h header').  Do you still need to be CC'd on the clkdev.c
changes?

regards,
dan carpenter
