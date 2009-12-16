From: abhijitpagare@ti.com (Pagare, Abhijit)
Date: Wed, 16 Dec 2009 10:41:19 +0530
Subject: [v2 PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support OMAP4
	features.
In-Reply-To: <alpine.DEB.2.00.0912150950050.12561@utopia.booyaka.com>
References: <1260885177-25665-1-git-send-email-abhijitpagare@ti.com>
	<1260885177-25665-2-git-send-email-abhijitpagare@ti.com>
	<1260885177-25665-3-git-send-email-abhijitpagare@ti.com>
	<1260885177-25665-4-git-send-email-abhijitpagare@ti.com>
	<1260885177-25665-5-git-send-email-abhijitpagare@ti.com>
	<alpine.DEB.2.00.0912150950050.12561@utopia.booyaka.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BFB57DB8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, December 15, 2009 10:23 PM
> To: Pagare, Abhijit
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Cousson, Benoit; Nayak, Rajendra
> Subject: Re: [v2 PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support
> OMAP4 features.
> 
> Hi Abhijit,
> 
> just FYI, on this patch:
> 
> On Tue, 15 Dec 2009, Abhijit Pagare wrote:
> 
> > Port the APIs to support the OMAP4 clockdomain framework.
> > Also take care of the compiling requirements for the same.
> 
> ...
> 
> > diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-
> omap2/clockdomain.c
> > index 5366a10..f768d37 100644
> > --- a/arch/arm/mach-omap2/clockdomain.c
> > +++ b/arch/arm/mach-omap2/clockdomain.c
> > @@ -1,10 +1,11 @@
> >  /*
> > - * OMAP2/3 clockdomain framework functions
> > + * OMAP2/3/4 clockdomain framework functions
> >   *
> >   * Copyright (C) 2008 Texas Instruments, Inc.
> >   * Copyright (C) 2008-2009 Nokia Corporation
> >   *
> >   * Written by Paul Walmsley and Jouni H????gander
> 
> ... looks like something mangled the UTF-8 which causes this patch to
> not apply cleanly.  Fixed this up by hand.

It's fine. Thanks..!

> 
> 
> - Paul

Regards,
Abhijit
