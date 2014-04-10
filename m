From: b32955@freescale.com (Huang Shijie)
Date: Thu, 10 Apr 2014 15:27:12 +0800
Subject: [PATCH v5 3/8] mtd: spi-nor: add the framework for SPI NOR
In-Reply-To: <20140409174837.GE32070@ld-irv-0074>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <1393238262-8622-4-git-send-email-b32955@freescale.com>
 <20140409174837.GE32070@ld-irv-0074>
Message-ID: <20140410072711.GB24100@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 10:48:37AM -0700, Brian Norris wrote:
> On Mon, Feb 24, 2014 at 06:37:37PM +0800, Huang Shijie wrote:
> > This patch cloned most of the m25p80.c. In theory, it adds a new spi-nor layer.
> ...
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > new file mode 100644
> > index 0000000..a840e88
> > --- /dev/null
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -0,0 +1,1087 @@
> > +/*
> > + * Cloned most of the code from the m25p80.c
> 
> Please include a copyright notice here. This should carry both the
> original m25p80.c copyright notice, as well as your own additional
> copyright if you choose. For instance:
> 
>  * Based on m25p80.c, by Mike Lavender (mike at steroidmicros.com), with
>  * influence from lart.c (Abraham Van Der Merwe) and mtd_dataflash.c
>  *
>  * Copyright ? 2005, Intec Automation Inc.
>  * Copyright ? 2014, Freescale Semiconductor, Inc.
> 
I will send a patch to add the copyright info which will based on your patch
set.

thanks
Huang Shijie
