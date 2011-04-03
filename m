From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Apr 2011 13:27:13 +0100
Subject: [PATCH 1/2] ARM: Make consolidated PM sleep code depend on
	PM_SLEEP
In-Reply-To: <87ipuvr2xg.fsf@lebrac.rtp-net.org>
References: <20110402091904.GH8482@n2100.arm.linux.org.uk>
	<E1Q5x0g-0001Yw-Vb@rmk-PC.arm.linux.org.uk>
	<87ipuvr2xg.fsf@lebrac.rtp-net.org>
Message-ID: <20110403122713.GD4213@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2011 at 01:26:35PM +0200, Arnaud Patard wrote:
> I've build-tested on some failing platforms theses 2 patches and the
> build are now succeeding. The only PM related zImage build error I found
> was for s5pc100:
> 
> arch/arm/plat-samsung/pm.c:32:26: fatal error: mach/pm-core.h: No such file or directory

That probably existing from before the consolidation patch, so I won't
worry about it.
