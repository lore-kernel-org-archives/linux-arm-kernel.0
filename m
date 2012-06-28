From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 28 Jun 2012 09:59:03 +0800
Subject: [PATCH v7 06/14] USB: Chipidea: rename struct ci13xxx variables
 from udc to ci
In-Reply-To: <4FEAFFB7.7010906@pengutronix.de>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-7-git-send-email-richard.zhao@freescale.com>
 <4FEAFFB7.7010906@pengutronix.de>
Message-ID: <20120628015902.GA14953@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 02:42:31PM +0200, Marc Kleine-Budde wrote:
> On 06/25/2012 08:56 AM, Richard Zhao wrote:
> > struct ci13xxx represent the controller, which may be device or host,
> > so name its variables as ci.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> nitpick: search-replace problem
> 
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * udc.c - ChipIdea UDC driver
> > + * ci.c - ChipIdea UDC driver
>       ^^^^
Nice catch!

Thanks
Richard
> 
> :)
> 
> >   *
> >   * Copyright (C) 2008 Chipidea - MIPS Technologies, Inc. All rights reserved.
> >   *
> > @@ -66,11 +66,11 @@ static inline int hw_ep_bit(int num, int dir)
> >  	return num + (dir ? 16 : 0);
> >  }
> >  
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
