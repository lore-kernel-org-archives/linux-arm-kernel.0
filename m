From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jan 2014 17:24:13 +0000
Subject: [BUG] shmobile build failure
Message-ID: <20140102172413.GB7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

allmodconfig and allyesconfig fail with this error:

arch/arm/mach-shmobile/setup-rcar-gen2.c:21:32: fatal error: linux/clk/shmobile.h: No such file or directory

My guess is that shmobile on its own doesn't build because of this.
Is there a screwed dependency between arm-soc and the clk git trees?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
