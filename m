From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 30 Aug 2016 19:23:53 +0000
Subject: [PATCH 1/1] mach-hisi: Make Hi3620 explicit, remove wildcard
In-Reply-To: <20160830191729.GT10637@io.lakedaemon.net>
References: <07dd3b37-3cd9-6f89-4c84-ce534880d200@gmail.com>
 <20160830191729.GT10637@io.lakedaemon.net>
Message-ID: <20160830192353.GU10637@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 07:17:29PM +0000, Jason Cooper wrote:
> > Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
> > ---
> 
> This needs to be split up into a series of patches:
> 
> >  arch/arm/Kconfig.debug              |  2 +-
> 
> >  arch/arm/boot/dts/Makefile          |  2 +-
> 
> >  arch/arm/configs/hisi_defconfig     |  2 +-
> 
> >  arch/arm/configs/multi_v7_defconfig |  2 +-
> 
> >  arch/arm/mach-hisi/Kconfig          |  6 +++---
> >  arch/arm/mach-hisi/core.h           | 10 +++++-----
> >  arch/arm/mach-hisi/hisilicon.c      |  4 ++--
> >  arch/arm/mach-hisi/hotplug.c        | 16 ++++++++--------
> >  arch/arm/mach-hisi/platsmp.c        | 24 ++++++++++++------------
> 
> >  drivers/clk/hisilicon/Makefile      |  2 +-
> 
> >  drivers/dma/Kconfig                 |  2 +-
> 
> Most likely, the subsystem maintainers will Ack the relevant patch and
> then they'll go in together to avoid bisection issues.

Crap.  I forgot to add, use scripts/get_maintainer.pl on the patches to
figure out who to Cc for each patch.  That way, the DMA maintainer
should get the coverletter (explaining the big picture for the series),
and the DMA patch.

hth,

Jason.
