From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 Aug 2012 19:06:54 -0700
Subject: [PATCH 2/4] ARM: OMAP: Split plat/hardware.h, introduce local
 hardware.h and soc.h for omap2+
In-Reply-To: <20120901002753.GA21451@opensource.wolfsonmicro.com>
References: <20120901002534.23715.28654.stgit@muffinssi.local>
 <20120901002622.23715.68557.stgit@muffinssi.local>
 <20120901002753.GA21451@opensource.wolfsonmicro.com>
Message-ID: <20120901020654.GT1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120831 17:28]:
> On Fri, Aug 31, 2012 at 05:26:22PM -0700, Tony Lindgren wrote:
> > As the plat and mach includes need to disappear for single zImage work,
> > we need to remove plat/hardware.h.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> There's a topic/omap branch in ASoC which you can pull in to help reduce
> conflicts, or I could merge this there if that's sensible.

Thanks. Did not see it yet at git://opensource.wolfsonmicro.com/linux-2.6-asoc,
maybe it's not yet pushed out?

Tony
