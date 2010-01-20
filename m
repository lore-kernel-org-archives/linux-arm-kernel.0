From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Jan 2010 15:43:56 +0100
Subject: make PHYS_OFFSET determined at run time (unfinished)
In-Reply-To: <1263998346.3207.83.camel@linux-1lbu>
References: <20100119083803.GA17904@pengutronix.de>
	<4B561581.6060400@bluewatersys.com>
	<20100120005505.GD26562@trinity.fluff.org>
	<1263954112.3207.73.camel@linux-1lbu>
	<20100120023255.GV10014@trinity.fluff.org>
	<1263998346.3207.83.camel@linux-1lbu>
Message-ID: <20100120144356.GA20271@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,

> > > Is there a clean way to pass kernel parameters and machine type from
> > > u-boot to zImage?  Last time I boot zImage in u-boot, some ugly hack was
> > > needed in ARM startup code.  Just wondering if there is a better way.
> > 
> > u-boot should be doing the right thing, I thought uImage was simply a
> > zImage wrapped in the right uboot descriptors to tell uboot it was a
> > kernel and where to load it.
> > 
> > Certianly uboots i've used can boto zImage just fine.
> 
> I'm also able to boot zImage under u-boot.  However, I had to set r1
> manually, and I don't know how to pass kernel parameters (stuff passed
> into kernel uImage via bootargs) to zImage.  Any tips will be greatly
> appreciated.
Maybe this doesn't help you much, but barebox (aka. u-boot-v2) can boot
zImages just fine and passes the cmdline as with booting an uImage.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
