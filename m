From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Apr 2011 20:50:33 +0900
Subject: [PATCH 1/2] ARM: Make consolidated PM sleep code depend
	on	PM_SLEEP
In-Reply-To: <20110403122713.GD4213@n2100.arm.linux.org.uk>
References: <20110402091904.GH8482@n2100.arm.linux.org.uk>
	<E1Q5x0g-0001Yw-Vb@rmk-PC.arm.linux.org.uk>
	<87ipuvr2xg.fsf@lebrac.rtp-net.org>
	<20110403122713.GD4213@n2100.arm.linux.org.uk>
Message-ID: <02c801cbf2be$843a9190$8cafb4b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Sun, Apr 03, 2011 at 01:26:35PM +0200, Arnaud Patard wrote:
> > I've build-tested on some failing platforms theses 2 patches and the
> > build are now succeeding. The only PM related zImage build error I found
> > was for s5pc100:
> >
> > arch/arm/plat-samsung/pm.c:32:26: fatal error: mach/pm-core.h: No such
file
> or directory
> 
> That probably existing from before the consolidation patch, so I won't
> worry about it.

Yeah, Russell is right :)

I will sort it out.
Thanks for your pointing out.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
