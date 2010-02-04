From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Thu, 04 Feb 2010 17:02:40 +0100
Subject: [PATCH 4/8] i.MX35: Add USB control register access support
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <ly3a1hxa3j.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> +#define MX35_OTG_IPPUE_UP_BIT	(1 << 7)
> +#define MX35_OTG_IPPUE_DOWN_BIT	(1 << 6)
> ...
> +#define MX35_OTG_USBTE_BIT	(1 << 4)

Why are these bits called '_OTG_'?  They are applied in the 'H1 port'
case and reference manual mentions them only for the USB host part.



Enrico
