From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 May 2015 21:13:28 +0200
Subject: [PATCH v4 5/7] clk: zx: add clock support to zx296702
In-Reply-To: <20150516130756.GF10411@tiger>
References: <1430212691-16009-1-git-send-email-jun.nie@linaro.org>
 <6693731.YF8XsCYmbE@wuerfel> <20150516130756.GF10411@tiger>
Message-ID: <12864750.VWIHuvOnir@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 May 2015 21:07:57 Shawn Guo wrote:
> On Fri, May 15, 2015 at 10:32:14PM +0200, Arnd Bergmann wrote:
> > On Tuesday 28 April 2015 17:18:09 Jun Nie wrote:
> > > diff --git a/include/dt-bindings/clock/zx296702-clock.h b/include/dt-bindings/clock/zx296702-clock.h
> > > new file mode 100644
> > > index 0000000..c5e7ec2
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/zx296702-clock.h
> > > @@ -0,0 +1,162 @@
> > > +/*
> > > + * Copyright 2014 Linaro Ltd.
> > > + * Copyright (C) 2014 ZTE Corporation.
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#ifndef __DT_BINDINGS_CLOCK_ZX296702_H
> > > +#define __DT_BINDINGS_CLOCK_ZX296702_H
> > > +
> > > +#define ZX296702_OSC                           0
> > > +#define ZX296702_PLL_A9                                1
> > > +#define ZX296702_PLL_A9_350M                   2
> > > +#define ZX296702_PLL_MAC_1000M                 3
> > > +#define ZX296702_PLL_MAC_333M                  4
> > > +#define ZX296702_PLL_MM0_1188M                 5
> > > +#define ZX296702_PLL_MM0_396M                  6
> > > +#define ZX296702_PLL_MM0_198M                  7
> > > +#define ZX296702_PLL_MM1_108M                  8
> > > +#define ZX296702_PLL_MM1_72M                   9
> > > 
> > 
> > No objections for this driver going through Mike's tree, but as I said
> > if you want the dts file to be merged in the same merge window, it would
> > be best to avoid the header file.
> 
> Alternatively, we can ask an ACK from Mike or Stephen on this patch, so
> that we can merge the whole series through arm-soc tree.  As this patch
> adds a SoC specific clock driver and it's quite self-contained and
> shouldn't cause non-trivial merge conflicts, Mike/Stephen may be happy
> to give an ACK on it.
> 

Yes, that would work too.

	Arnd
