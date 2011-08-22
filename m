From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Aug 2011 10:10:00 +0200
Subject: 46dcfc8 (ARM: Update mach-types) removes used machine types
Message-ID: <20110822081000.GA16557@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

your commit 46dcfc8 that is in today's next among other changes does:

-eukrea_cpuimx25sd      MACH_EUKREA_CPUIMX25    EUKREA_CPUIMX25 2820
-eukrea_cpuimx35sd      MACH_EUKREA_CPUIMX35    EUKREA_CPUIMX35 2821

These two are both marked as "mainlined" on
http://www.arm.linux.org.uk/developer/machines/ and both are actually
used (arch/arm/mach-imx/mach-{eukrea_cpuimx25,cpuimx35.c})

Can you please add them back? Maybe it's worth to double-check the other
deletions?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
