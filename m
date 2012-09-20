From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Sep 2012 21:24:34 -0400
Subject: [PATCH 08/29] ARM: OMAP2+: Make board-zoom.h local
In-Reply-To: <20120919210554.28074.2280.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210554.28074.2280.stgit@muffinssi>
Message-ID: <20120920012433.GC17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 02:05:54PM -0700, Tony Lindgren wrote:
> This can be local to mach-omap2 after we rip out the messed up
> extmute stuff from board-zoom-peripherals.c that's all over
> the place and probably does not even work because of all the
> hardcoded GPIO numbers.
> 
> I also suggest ASoC gusy remove all extmute handling from
> sound/soc/codecs/twl4030.c unless it's been tested to work
> and implemented in a saner way.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

or I can apply it if that's easier.
