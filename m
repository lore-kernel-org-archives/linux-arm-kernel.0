From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Nov 2012 09:37:04 +0000
Subject: OMAP build now completely broken in latest arm-soc
Message-ID: <20121125093704.GV3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not much more to say...

arch/arm/plat-omap/i2c.c:35:1: error: expected identifier or '(' before '<<' token

But also, the:

arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used

warning is still there.
