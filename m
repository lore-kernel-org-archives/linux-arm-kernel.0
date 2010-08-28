From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 28 Aug 2010 17:18:17 +0200
Subject: [PATCH 3/3 v2] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <20100823174852.GB26928@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-4-git-send-email-s.hauer@pengutronix.de>
	<20100823125704.GU27749@pengutronix.de>
	<20100823174852.GB26928@pengutronix.de>
Message-ID: <AANLkTimmEKfErV17RWNBO-pVCfFtFw=yJL2v92UBN0=2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/23 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

>> + ? ? evt = readl(SDMA_H_EVTOVR);
>> + ? ? mcu = readl(SDMA_H_HOSTOVR);
>> + ? ? dsp = readl(SDMA_H_DSPOVR);
> __raw_readl?

Sorry I never understood this __raw_[read|write][b|w|l] vs.
plain read[b|w|l] proliferation in some drivers and code.

What's the reason for?

Yours,
Linus Walleij
