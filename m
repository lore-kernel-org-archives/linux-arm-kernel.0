From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 6 Sep 2011 10:46:27 +0200
Subject: [PATCH] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <20110906083926.GE28816@pengutronix.de>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>
	<20110906083926.GE28816@pengutronix.de>
Message-ID: <20110906084627.GB2610@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  
> > +config MODULE_M28
> > +	bool
> > +	select SOC_IMX28
> > +	select LEDS_GPIO_REGISTER
> > +	select MXS_HAVE_AMBA_DUART
> > +	select MXS_HAVE_PLATFORM_AUART
> > +	select MXS_HAVE_PLATFORM_FEC
> > +	select MXS_HAVE_PLATFORM_FLEXCAN
> > +	select MXS_HAVE_PLATFORM_MXS_MMC
> > +	select MXS_HAVE_PLATFORM_MXSFB
> > +	select MXS_OCOTP
> > +
> >  config MACH_TX28
> >  	bool "Ka-Ro TX28 module"
> >  	select MODULE_TX28
> >  
> > +config MACH_M28EVK
> > +	bool "Support DENX M28EVK Platform"
> > +	select MODULE_M28
> > +

Does it build? I'd think MXS_HAVE_PLATFORM_MXS_I2C is missing?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110906/a2976158/attachment.sig>
