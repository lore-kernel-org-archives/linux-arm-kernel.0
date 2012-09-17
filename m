From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Sep 2012 14:30:35 +0000
Subject: [PATCH 16/34] ASoC: imx-ssi: remove unneeded mach/hardware.h
 inclusion
In-Reply-To: <20120917114543.GG5401@opensource.wolfsonmicro.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-17-git-send-email-shawn.guo@linaro.org>
 <20120917114543.GG5401@opensource.wolfsonmicro.com>
Message-ID: <201209171430.35804.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Mark Brown wrote:
> On Mon, Sep 17, 2012 at 01:34:45PM +0800, Shawn Guo wrote:
> 
> >  #include <linux/platform_data/asoc-imx-ssi.h>
> > -#include <mach/hardware.h>
> 
> This doesn't apply - there's no platform data header for imx-ssi at the
> minute (and I don't see a patch in this series related to that in the
> series).  I checked -next and there doesn't seem to be anything via a
> non-ASoC tree either.
> 

It's in my testing/platform-data series, and will be in linux-next in
a few days.

	Arnd
