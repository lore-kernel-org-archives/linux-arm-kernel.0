From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Feb 2011 15:30:57 +0800
Subject: [PATCH 2/2] arm: mxs: add i2c-devices
In-Reply-To: <20110218211618.GI22310@pengutronix.de>
References: <1298049507-6987-1-git-send-email-w.sang@pengutronix.de>
	<1298049507-6987-3-git-send-email-w.sang@pengutronix.de>
	<20110218211618.GI22310@pengutronix.de>
Message-ID: <20110222073056.GA16141@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 10:16:18PM +0100, Uwe Kleine-K?nig wrote:
> 
> > diff --git a/arch/arm/mach-mxs/devices/platform-i2c.c b/arch/arm/mach-mxs/devices/platform-i2c.c
> > new file mode 100644
> > index 0000000..22236b2
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/devices/platform-i2c.c
> > @@ -0,0 +1,56 @@
> > +/*
> > + * Copyright (C) 2011 Pengutronix
> > + * Wolfram Sang <w.sang@pengutronix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it under
> > + * the terms of the GNU General Public License version 2 as published by the
> > + * Free Software Foundation.
> > + */
> > +#include <asm/sizes.h>
> > +#include <mach/mx28.h>
> > +#include <mach/devices-common.h>
> > +
> > +/* helper defines to fix MX23 naming anomaly */
> > +#define MX23_I2C0_BASE_ADDR	MX23_I2C_BASE_ADDR
> > +#define MX23_INT_I2C0_ERROR	MX23_INT_I2C_ERROR
> > +#define MX23_INT_I2C0_DMA	MX23_INT_I2C_DMA
> not needed yet, but OK
> 
It makes less sense to me to have these without including mx23.h.

-- 
Regards,
Shawn
