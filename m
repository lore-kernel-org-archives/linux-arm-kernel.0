From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Sep 2011 09:46:26 +0200
Subject: [PATCH] Add platform driver support to the CS890x driver
In-Reply-To: <20110913074424.GY31404@pengutronix.de>
References: <1315390967-6683-1-git-send-email-jaccon.bastiaansen@gmail.com>
	<20110907125047.GU28816@pengutronix.de>
	<20110913074424.GY31404@pengutronix.de>
Message-ID: <20110913074626.GM28624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Sep 13, 2011 at 09:44:24AM +0200, Sascha Hauer wrote:
> On Wed, Sep 07, 2011 at 02:50:47PM +0200, Uwe Kleine-K?nig wrote:
> > > +		printk(KERN_WARNING
> > > +		       DRV_NAME
> > > +		       ": memory and/or interrupt resource missing.\n");
> > I'd prefer you do:
> > 
> > 	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > 
> > at the top of the driver and then just use:
> > 
> > 	pr_warning("memory and/or interrupt resource missing\m");
> 
> Why not use dev_warn??
Yeah, that works, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
