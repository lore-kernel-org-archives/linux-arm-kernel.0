From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 May 2015 07:58:41 -0700
Subject: [GIT PULL 2/2] omap1 sparse irq support for v4.2
In-Reply-To: <80194352.chs4cqVdmg@wuerfel>
References: <80194352.chs4cqVdmg@wuerfel>
Message-ID: <20150521145840.GQ10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [150521 05:13]:
> On Wednesday 20 May 2015 15:36:05 Tony Lindgren wrote:
> > Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
> > to making omap1 support multiarch. After this series we still need to
> > make omap1 use the common clock framework and fix up the drivers to not
> > rely on includes from mach and plat directories.
> > 
> > Note that this branch depends on a GPIO driver fix in v4.1-rc3
> > d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").
> > 
> 
> I'm getting lots of build errors in linux-next, which I think are
> caused by this series.

Hmm is this with make randconfig? What's the Kconfig option enabling
these errors?

Regards,

Tony
