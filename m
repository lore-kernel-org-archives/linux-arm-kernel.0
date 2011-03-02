From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Mar 2011 09:37:37 +0100
Subject: [PATCH 1/5] ARM: mx35_3ds: Add I2C support
In-Reply-To: <AANLkTi=c_vWNqBbqPzRpCzWD-s5PFvLmD8ROr=Jss1hA@mail.gmail.com>
References: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
	<20110301201703.GX22310@pengutronix.de>
	<AANLkTi=c_vWNqBbqPzRpCzWD-s5PFvLmD8ROr=Jss1hA@mail.gmail.com>
Message-ID: <20110302083736.GR29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 03:14:30PM +0800, Jason Liu wrote:
> Hi, Uwe,
> 
> 2011/3/2 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > On Tue, Mar 01, 2011 at 04:59:44PM -0300, Fabio Estevam wrote:
> >> + ? ? imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
> > I'd slightly prefer using
> >
> > ? ? ? ?imx35_add_imx_i2c(0, ...)
> >
> > because I intend to remove the imx35_add_imx_i2c0-like macros soon. ?But
> 
> Could you please explain why you intend to remove
> imx35_add_imx_i2c0-like macros?
> What you would like to do instead? Thanks,

These just produce additional macros without value.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
