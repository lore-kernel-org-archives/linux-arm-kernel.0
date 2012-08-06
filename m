From: marex@denx.de (Marek Vasut)
Date: Mon, 6 Aug 2012 05:53:50 +0200
Subject: [PATCH 2/3 V2] IIO: Add basic MXS LRADC driver
In-Reply-To: <20120806023743.GC18471@S2101-09.ap.freescale.net>
References: <1344007721-11595-1-git-send-email-marex@denx.de>
 <1344007721-11595-3-git-send-email-marex@denx.de>
 <20120806023743.GC18471@S2101-09.ap.freescale.net>
Message-ID: <201208060553.50398.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Fri, Aug 03, 2012 at 05:28:40PM +0200, Marek Vasut wrote:
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> 
> <snip>
> 
> > +#include <mach/mxs.h>
> > +#include <mach/common.h>
> > +
> 
> Why do you need these two mach headers?

Might be just some remnant ... any further comments please?

Best regards,
Marek Vasut
