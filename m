From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 16 Feb 2010 20:43:06 +0100
Subject: [PATCH 08/14] ARM: LPC32XX: Phytec 3250 platform support
In-Reply-To: <20100212200813.GB947@pengutronix.de>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-9-git-send-email-wellsk40@gmail.com>
	<20100212200813.GB947@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805CC9E1A61@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +	gpio_request(LCD_POWER_GPIO, "LCD power");
> > +	gpio_direction_output(LCD_POWER_GPIO, 1);
> > +	gpio_request(BKL_POWER_GPIO, "LCD backlight power");
> > +	gpio_direction_output(BKL_POWER_GPIO, 1);
> I'd check the return values of the gpio_... functions.
> 

I'll get all the comments installed and get an updated set of
patches up this week.
