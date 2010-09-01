From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 1 Sep 2010 14:39:08 +0200
Subject: [PATCH 08/13] PXA: Colibri: Toradex Colibri PXA270 CF support
In-Reply-To: <20100901072304.GE8142@n2100.arm.linux.org.uk>
References: <1281673964-2119-1-git-send-email-marek.vasut@gmail.com>
	<1281673964-2119-8-git-send-email-marek.vasut@gmail.com>
	<20100901072304.GE8142@n2100.arm.linux.org.uk>
Message-ID: <201009011439.09191.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 1. z??? 2010 09:23:05 Russell King - ARM Linux napsal(a):
> On Fri, Aug 13, 2010 at 06:32:39AM +0200, Marek Vasut wrote:
> > diff --git a/drivers/pcmcia/pxa2xx_colibri.c
> > b/drivers/pcmcia/pxa2xx_colibri.c new file mode 100644
> > index 0000000..8373816
> > --- /dev/null
> > +++ b/drivers/pcmcia/pxa2xx_colibri.c
> > @@ -0,0 +1,215 @@
> > +/*
> > + * linux/drivers/pcmcia/pxa2xx_colibri.c
> > + *
> > + * Driver for Toradex Colibri PXA270 CF socket
> > + *
> > + * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/delay.h>
> > +
> > +#include <asm/mach-types.h>
> > +
> > +#include <mach/gpio.h>
> 
> linux/gpio.h please.

Thanks, good catch. I fixed this in my tree.
