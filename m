From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jul 2011 09:41:25 +0200
Subject: [PATCH] ARM: mx50: Select IMX_HAVE_PLATFORM_FEC as done on other
	i.MX devices
In-Reply-To: <20110725211400.GN16561@pengutronix.de>
References: <1311621941-4227-1-git-send-email-festevam@gmail.com>
	<20110725211400.GN16561@pengutronix.de>
Message-ID: <20110726074125.GH20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 11:14:00PM +0200, Uwe Kleine-K?nig wrote:
> Hello Fabio,
> 
> On Mon, Jul 25, 2011 at 04:25:41PM -0300, Fabio Estevam wrote:
> > -	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
> > +	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53 || SOC_IMX50
> Maybe add i.MX50 between 35 and 51? I don't care much though.

Me neither. Applied.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
