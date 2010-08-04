From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 05 Aug 2010 07:33:49 +0900
Subject: [PATCH 2/3] ARM: Samsung: Don't use the mach/gpio.h directly
In-Reply-To: <4C597503.3030809@simtec.co.uk>
References: <20100802002511.GA32261@july> <4C597503.3030809@simtec.co.uk>
Message-ID: <003b01cb3425$1f0ef7a0$5d2ce6e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> 
> On 02/08/10 01:25, Kyungmin Park wrote:
> > Use the linux/gpio.h. also fix the build error since new C preprocessor
directives.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Ben Dooks <ben-linux@fluff.org>

Ok...will apply this into my tree.

> > ---
> >  arch/arm/plat-samsung/gpiolib.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/gpiolib.c
b/arch/arm/plat-samsung/gpiolib.c
> > index 8a8ba8b..c354089 100644
> > --- a/arch/arm/plat-samsung/gpiolib.c
> > +++ b/arch/arm/plat-samsung/gpiolib.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/irq.h>
> >  #include <linux/io.h>
> > -#include <mach/gpio.h>
> > +#include <linux/gpio.h>
> >  #include <plat/gpio-core.h>
> >  #include <plat/gpio-cfg.h>
> >  #include <plat/gpio-cfg-helpers.h>


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
