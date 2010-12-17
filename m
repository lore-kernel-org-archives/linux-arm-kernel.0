From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 Dec 2010 19:34:11 +0530
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <e267a5979c1e20671daa063110dc9a1c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Friday, December 17, 2010 5:02 PM
> To: Alessandro Rubini; Bryan Huntsman; Colin Cross; Daniel Walker; David
> Brown; Eric Miao; Erik Gilling; Hans J. Koch; Imre Kaloz; Kevin Hilman;
> Krzysztof Halasa; Kukjin Kim; Lennert Buytenhek; Jiandong Zheng; Linus
> Walleij; linux-arm-msm at vger.kernel.org; linux-omap at vger.kernel.org;
linux-
> samsung-soc at vger.kernel.org; linux-tegra at vger.kernel.org; Nicolas Pitre;
> Olof Johansson; Sascha Hauer; Scott Branden; STEricsson; Tony Lindgren;
> Viresh Kumar; Wan ZongShun
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
>
> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted.  There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
>
> Still looking for acks or tested-by's for these patches.

Have boot tested this series on OMAP4430 SDP and OMAP3630
ZOOM.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards,
Santosh
