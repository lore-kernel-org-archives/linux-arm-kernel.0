From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 May 2014 17:17:56 +0200
Subject: [PATCH v3 3/7] mfd: add support for sun6i PRCM
 (Power/Reset/Clock Management) unit
In-Reply-To: <20140509135251.GY5767@lee--X1>
References: <1399633911-7094-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399633911-7094-4-git-send-email-boris.brezillon@free-electrons.com>
 <20140509135251.GY5767@lee--X1>
Message-ID: <20140515151756.GX29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, May 09, 2014 at 02:52:51PM +0100, Lee Jones wrote:
> > The PRCM (Power/Reset/Clock Management) block exposes several subdevices
> > in different subsystems (clk, reset ...)
> > 
> > Add basic support for the PRCM unit with clk (AR100, AHB0, and APB0 clks)
> > and reset controller subdevices.
> > 
> > Other subdevices might be added later (if needed).
> > 
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mfd/Kconfig      |   8 +++
> >  drivers/mfd/Makefile     |   1 +
> >  drivers/mfd/sun6i-prcm.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 143 insertions(+)
> >  create mode 100644 drivers/mfd/sun6i-prcm.c
> 
> [...]
> 
> > +/*
> > + * Copyright (C) 2014 Free Electrons
> > + *
> > + * License Terms: GNU General Public License v2
> > + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > + *
> > + * Allwinner PRCM (Power/Reset/Clock Management) driver
> > + *
> > + */
> > +
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> 
> Ah, now isn't that better?
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

How do you want to merge this? Do you want me to take it through
mach-sunxi tree, or do you want to take it in your tree?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/695c1d6b/attachment.sig>
