From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 31 Aug 2012 17:27:54 -0700
Subject: [PATCH 2/4] ARM: OMAP: Split plat/hardware.h, introduce local
 hardware.h and soc.h for omap2+
In-Reply-To: <20120901002622.23715.68557.stgit@muffinssi.local>
References: <20120901002534.23715.28654.stgit@muffinssi.local>
 <20120901002622.23715.68557.stgit@muffinssi.local>
Message-ID: <20120901002753.GA21451@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 05:26:22PM -0700, Tony Lindgren wrote:
> As the plat and mach includes need to disappear for single zImage work,
> we need to remove plat/hardware.h.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

There's a topic/omap branch in ASoC which you can pull in to help reduce
conflicts, or I could merge this there if that's sensible.
