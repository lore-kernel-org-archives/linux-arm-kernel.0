From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Feb 2018 07:09:00 -0800
Subject: [PATCH v7 3/9] arm: omap: Move dmtimer.h out of plat-omap
In-Reply-To: <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-4-git-send-email-j-keerthy@ti.com>
 <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
Message-ID: <20180213150900.GD6364@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [180213 02:07]:
> On 01/09/2018 12:23 AM, J, KEERTHY wrote:
> > The header file is currently under plat-omap directory
> > under arch/omap. Move this out to an accessible place.
> > @@ -18,7 +18,7 @@
> >   #include <linux/platform_data/hsmmc-omap.h>
> >   #include <linux/platform_data/spi-omap2-mcspi.h>
> >   #include <linux/omap-dma.h>
> > -#include <plat/dmtimer.h>
> > +#include <clocksource/dmtimer.h>
> 
> These headers are actually not needed in the first-place since we no
> longer create any non-DT timer devices. I have submitted a series to
> cleanup the presence of this header file, as part of a larger hwmod data
> cleanup series.

OK great. Keerthy, care to take a look? Seems like it
simplifies things a bit.

Regards,

Tony
