From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 4 Dec 2009 12:24:01 +0200
Subject: [RFC][PATCH 02/10] arm: mxc: base support for Freescale i.MX51
	processor
In-Reply-To: <20091204094122.GC10910@pengutronix.de>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<6608c4dca645d87efce78ae0b7dbad265004f482.1259893118.git.amit.kucheria@canonical.com>
	<20091204094122.GC10910@pengutronix.de>
Message-ID: <20091204102401.GB3747@matterhorn.verdurent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09 Dec 04, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Dec 04, 2009 at 04:47:02AM +0200, Amit Kucheria wrote:
> > Kconfig and Makefiles to enable the i.MX51 processor separated to help ease
> > the review process
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> > ---

<snip>

> > diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> > new file mode 100644
> > index 0000000..e4cf91f
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/Makefile
> > @@ -0,0 +1,9 @@
> > +#
> > +# Makefile for the linux kernel.
> > +#
> > +
> > +# Object file lists.
> > +obj-y   := cpu.o mm.o clock.o devices.o
> I couldn't find arch/arm/mach-mx5/cpu.c neither in your series nor in
> mainline.  Didn't check the others.  Is it just me?

Patch 05/10 is stuck in the L-A-K moderation queue for size restrictions.
Perhaps you could get it from LKML archives[1]?

[1] http://lkml.org/lkml/2009/12/3/500

Regards,
Amit
-- 
------------------------------------------------------------
Amit Kucheria, Finland
------------------------------------------------------------
