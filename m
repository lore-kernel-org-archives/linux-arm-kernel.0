From: jdzheng@broadcom.com (JD (Jiandong) Zheng)
Date: Wed, 22 Dec 2010 13:59:44 -0800
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock
 patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AADDDEFDDD15E@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add my ack to [PATCH 02/40] ARM: bcmring: update clock source registration:

Acked-By: Jiandong Zheng <jdzheng@broadcom.com>

Thanks,
Jiandong Zheng

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Friday, December 17, 2010 3:32 AM
To: Alessandro Rubini; Bryan Huntsman; Colin Cross; Daniel Walker; David Brown; Eric Miao; Erik Gilling; Hans J. Koch; Imre Kaloz; Kevin Hilman; Krzysztof Halasa; Kukjin Kim; Lennert Buytenhek; JD (Jiandong) Zheng; Linus Walleij; linux-arm-msm at vger.kernel.org; linux-omap at vger.kernel.org; linux-samsung-soc at vger.kernel.org; linux-tegra at vger.kernel.org; Nicolas Pitre; Olof Johansson; Sascha Hauer; Scott Branden; STEricsson; Tony Lindgren; Viresh Kumar; Wan ZongShun
Cc: linux-arm-kernel at lists.infradead.org
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches

Here is the entire set of clocksource and sched_clock patches which
have been previously posted.  There's a couple of small tweaks in a
few of the patches (such as adding notrace to OMAP clocksource read
functions), and this also shows the proper ordering of these patches.

Still looking for acks or tested-by's for these patches.
