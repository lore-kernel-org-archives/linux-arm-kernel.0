From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Tue, 10 Aug 2010 16:03:39 +0200
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
In-Reply-To: <AANLkTikKFg62x_=BSZ29OaGz9=abk6PWN_u-+BvjB6Kw@mail.gmail.com>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
	<m2k4ny3jtn.fsf@ohwell.denx.de>
	<AANLkTikKFg62x_=BSZ29OaGz9=abk6PWN_u-+BvjB6Kw@mail.gmail.com>
Message-ID: <19553.23611.216618.916355@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Timur Tabi writes:
> On Tuesday, August 10, 2010, Detlev Zundel <dzu@denx.de>
> > Apart from this I would also welcome if the whole driver could be
> > adapted to the drivers/dma dmaengine API as pointed out by Linus
> > Walleij. ?The dma controller support for the Power Architecture chips of
> > Freescale do implement this API, so this would also be a great step
> > towards code unification of drivers here.
> 
> The Freescale PowerPC and ARM DMA controllers are completely
> different, so I don't see how the drivers could be unified.
> 
The DMA API should abstract away the differences in the hardware
so that device drivers could use DMA without having to know on what
hardware they are running.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
