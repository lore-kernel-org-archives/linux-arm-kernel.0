From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 21 Nov 2009 20:17:18 +0100
Subject: [PATCH] ARM: MX3: fix CPU revision number detection
In-Reply-To: <20091121190037.GE13956@n2100.arm.linux.org.uk>
References: <1258820364-32693-1-git-send-email-daniel@caiaq.de>
	<20091121190037.GE13956@n2100.arm.linux.org.uk>
Message-ID: <20091121191718.GD14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 07:00:37PM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 21, 2009 at 05:19:24PM +0100, Daniel Mack wrote:
> > diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
> > new file mode 100644
> > index 0000000..b09f338
> > --- /dev/null
> > +++ b/arch/arm/mach-mx3/cpu.c
> > @@ -0,0 +1,57 @@
> > +/*
> > + * MX3 CPU type detection
> > + *
> > + * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <mach/hardware.h>
> > +#include <mach/iim.h>
> > +#include <asm/io.h>
> 
> I see red.  linux/io.h please.

Oops. See below.

Daniel
