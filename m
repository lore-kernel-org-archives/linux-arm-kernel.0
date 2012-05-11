From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 May 2012 15:17:16 +0000
Subject: [GIT PULL] mxs common clk porting for v3.5
In-Reply-To: <20120509022830.GA2234@S2101-09.ap.freescale.net>
References: <20120509022830.GA2234@S2101-09.ap.freescale.net>
Message-ID: <201205111517.16807.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Shawn Guo wrote:
> Please pull the mxs common clk porting below for v3.5.  It depends on
> the following two branches.
> 
> [1] git://git.linaro.org/people/mturquette/linux.git clk-next
> [2] http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git clkdev
> 
> As the mxs device tree conversion will constantly touch clock files,
> to save the conflicts, the updated mxs/dt branch coming later will
> based on this pull-request.  Please abandon the existing mxs/dt branch
> from arm-soc tree.

Pulled into next/clock.

Thanks,

	Arnd
