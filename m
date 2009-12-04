From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 4 Dec 2009 22:30:43 +0200
Subject: [RFC][PATCH 01/10] arm: mxc: New interrupt controller (TZIC)
	for i.MX5 family
In-Reply-To: <20091204090139.ff60024c.randy.dunlap@oracle.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<e99e70e2a619693064130a747b6ee3a93273337b.1259893118.git.amit.kucheria@canonical.com>
	<20091204090139.ff60024c.randy.dunlap@oracle.com>
Message-ID: <20091204203043.GF3747@matterhorn.verdurent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09 Dec 04, Randy Dunlap wrote:
> On Fri,  4 Dec 2009 04:47:01 +0200 Amit Kucheria wrote:
> 
> > Freescale i.MX51 processor uses a different interrupt controller. Add the
> > driver and fix the Makefile to account for it.
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> > ---
> >  arch/arm/plat-mxc/Kconfig  |    4 +
> >  arch/arm/plat-mxc/Makefile |    9 ++-
> >  arch/arm/plat-mxc/tzic.c   |  180 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 192 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/plat-mxc/tzic.c
> > 
> > diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
> > new file mode 100644
> > index 0000000..3af8fc6
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/tzic.c
> > @@ -0,0 +1,180 @@
> > +/*
> > + * Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> ...
> > +
> > +/*!
> > + * Disable interrupt number "irq" in the TZIC
> > + *
> > + * @param  irq          interrupt source number
> > + */
> 
> Hi,
> What processes these function comments (if anything does)?
> 

I'm afraid I can't help you there. It is probably an internal documentation standard inside Freescale. I'll get rid of the rest in the next submission.

Regards,
Amit

-- 
------------------------------------------------------------
Amit Kucheria, Finland
------------------------------------------------------------
