From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 12 May 2010 09:24:06 +0200
Subject: [PATCH 1/7] DMAENGINE: add generic PrimeCell interface to COH
	901 	318 v6
In-Reply-To: <AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A6DE7DA@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dan]

> What happens when two primecell dma devices are present on one soc?
> Can that happen?

Of course it can happen. In theory... There is no such system that
I'm aware of.

Peter's PL08x driver even model the PL08x as a singleton, i.e. a
static struct in the driver file.

> In that case we'll have conflicting providers of
> dma_set_ambaconfig().

Yes...

Linus
