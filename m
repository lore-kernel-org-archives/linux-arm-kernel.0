From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Fri, 21 Jan 2011 13:54:05 +0530
Subject: [PATCH] omap3: nand: bch ecc support added
In-Reply-To: <AANLkTimsD1108ASF3H9Y8pjaTsfv0D33K11KOXDmypvJ@mail.gmail.com>
References: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
	<AANLkTimsD1108ASF3H9Y8pjaTsfv0D33K11KOXDmypvJ@mail.gmail.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB174@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kishore Kadiyala [mailto:kishorek.kadiyala at gmail.com]
> Sent: Friday, January 21, 2011 1:42 PM
> To: Ghorai, Sukumar
> Cc: linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] omap3: nand: bch ecc support added
> 
> Ghorai,
> 
> <snip>
> 
> > ?#ifdef CONFIG_MTD_PARTITIONS
> > diff --git a/drivers/mtd/nand/omap_bch_decoder.c
> b/drivers/mtd/nand/omap_bch_decoder.c
> > new file mode 100644
> > index 0000000..da42bda
> > --- /dev/null
> > +++ b/drivers/mtd/nand/omap_bch_decoder.c
> > @@ -0,0 +1,393 @@
> > +/*
> > + * drivers/mtd/nand/omap_omap_bch_decoder.c
> > + *
> > + * Whole BCH ECC Decoder (Post hardware generated syndrome decoding)
> > + *
> > + * Copyright (c) 2007 Texas Instruments
> > + *
> > + * Author: Sukumar Ghorai <s-ghorai@ti.com
> > + * ? ? ? ? ? ? ? ?Michael Fillinger <m-fillinger@ti.com>
> 
> Vimal was the original author who has created this file
> [No change in file name/directory hierarchy].
> It's not fair to remove Vimal's author and add your's.
> 
> Instead you should have kept his name and added your's.
[Ghorai] Ok.  I will do .. 
But can you send me working version of these? At least comipled version for any kernel?

> 
> <snip>
> 
> Regards,
> Kishore
