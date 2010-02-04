From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 4 Feb 2010 17:22:56 +0100
Subject: [PATCH 4/8] i.MX35: Add USB control register access support
In-Reply-To: <ly3a1hxa3j.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
	<ly3a1hxa3j.fsf@ensc-virt.intern.sigma-chemnitz.de>
Message-ID: <20100204162256.GU6130@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 05:02:40PM +0100, Enrico Scholz wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > +#define MX35_OTG_IPPUE_UP_BIT	(1 << 7)
> > +#define MX35_OTG_IPPUE_DOWN_BIT	(1 << 6)
> > ...
> > +#define MX35_OTG_USBTE_BIT	(1 << 4)
> 
> Why are these bits called '_OTG_'?  They are applied in the 'H1 port'
> case and reference manual mentions them only for the USB host part.

You're right. Will fix

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
