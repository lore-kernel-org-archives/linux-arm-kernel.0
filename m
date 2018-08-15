From: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 15 Aug 2018 22:40:41 +0200
Subject: [PATCH v1 3/7] mfd: add atmel-lcdc driver
In-Reply-To: <20180815052435.GA6412@dell>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
 <20180815052435.GA6412@dell>
Message-ID: <20180815204041.GA29041@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee.

> > +
> > +static const struct mfd_cell lcdc_cells[] = {
> > +	{
> > +		.name = "atmel-lcdc-pwm",
> > +		.of_compatible = "atmel,lcdc-pwm",
> > +	},
> > +	{
> > +		.name = "atmel-lcdc-dc",
> > +		.of_compatible = "atmel,lcdc-display-controller",
> > +	},
> > +};
> 
> Will you be adding any more devices, or is this the entirety of the
> device?  If the latter, I suggest that this doesn't warrant being an
> MFD.
Thats it. And others agree with you that this is not a good approach.
So in v2 there will be no MFD.

Thanks for confirming that the non-mfd way is the better approach.

	Sam
