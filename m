From: yao.yuan@freescale.com (Yao Yuan)
Date: Fri, 20 Mar 2015 02:01:01 +0000
Subject: [PATCH 1/2] dma: Add Freescale qDMA engine driver support
In-Reply-To: <1426618604.15575.3.camel@x220>
References: <1426570119-8634-1-git-send-email-yao.yuan@freescale.com>
 <1426618604.15575.3.camel@x220>
Message-ID: <BL2PR03MB3388B4AE092A0726563F778830E0@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review. I will fix it in the next version.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Paul Bolle [mailto:pebolle at tiscali.nl]
> Sent: Wednesday, March 18, 2015 2:57 AM
> To: Yuan Yao-B46683
> Cc: vinod.koul at intel.com; shawn.guo at linaro.org; dan.j.williams at intel.com;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] dma: Add Freescale qDMA engine driver support
> 
> Just a license nit.
> 
> On Tue, 2015-03-17 at 13:28 +0800, Yuan Yao wrote:
> > --- /dev/null
> > +++ b/drivers/dma/fsl-qdma.c
> 
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> 
> This states the license is GPL v2 or later.
> 
> > +MODULE_LICENSE("GPL v2");
> 
> And
>     MODULE_LICENSE("GPL");
> 
> would match that statement.
> 
> 
> Paul Bolle
