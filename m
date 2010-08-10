From: timur@freescale.com (Timur Tabi)
Date: Tue, 10 Aug 2010 08:46:08 -0500
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
In-Reply-To: <m2k4ny3jtn.fsf@ohwell.denx.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
	<m2k4ny3jtn.fsf@ohwell.denx.de>
Message-ID: <AANLkTikKFg62x_=BSZ29OaGz9=abk6PWN_u-+BvjB6Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 10, 2010, Detlev Zundel <dzu@denx.de>
> Apart from this I would also welcome if the whole driver could be
> adapted to the drivers/dma dmaengine API as pointed out by Linus
> Walleij. ?The dma controller support for the Power Architecture chips of
> Freescale do implement this API, so this would also be a great step
> towards code unification of drivers here.

The Freescale PowerPC and ARM DMA controllers are completely
different, so I don't see how the drivers could be unified.


-- 
Timur Tabi
Linux kernel developer at Freescale
