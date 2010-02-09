From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 9 Feb 2010 20:17:58 +0100
Subject: [PATCH 01/14] ARM: LPC32XX: Initial architecture header files
In-Reply-To: <20100209093129.GA2284@pengutronix.de>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-2-git-send-email-wellsk40@gmail.com>
	<20100209093129.GA2284@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8C7550B@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks again Uwe for your time spent reviewing this and your
helpful comments!

> > diff --git a/arch/arm/mach-lpc32xx/include/mach/board.h b/arch/arm/mach-
> lpc32xx/include/mach/board.h
> > new file mode 100644
> > index 0000000..30424bc
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/include/mach/board.h
> > @@ -0,0 +1,23 @@
> > +/*
> > + * arch/arm/mach-lpc32xx/include/mach/board.h
> > + *
> > + * Author: Kevin Wells <kevin.wells@nxp.com>
> > + *
> > + * Copyright (C) 2010 NXP Semiconductors
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +
> nitpick: there is an empty line too much.
> 
> > +#ifndef __ASM_ARCH_BOARD_H
> > +#define __ASM_ARCH_BOARD_H
> > +
> > +#endif
> Do you really need this file?
> 

This file is a place holder. most of the other drivers for this
platform are already complete and a few add structures to this
file that are shared via platform data. I can remove it, but
would have to replace it later so I prefer to keep it now.

> > diff --git a/arch/arm/mach-lpc32xx/include/mach/clkdev.h
> b/arch/arm/mach-lpc32xx/include/mach/clkdev.h
> > new file mode 100644
> > index 0000000..9bf0637
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/include/mach/clkdev.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + * arch/arm/mach-lpc32xx/include/mach/clkdev.h
> > + *
> > + * Author: Kevin Wells <kevin.wells@nxp.com>
> hmmm, I wonder why you use your nxp address here, but gmail in the
> S-o-b.
> 

Corporate email + corporate IT + outlook = lots of problems with mailing lists
I'll change that address in git too.

Kevin
