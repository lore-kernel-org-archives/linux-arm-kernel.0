From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 23 Sep 2010 22:04:38 +0200
Subject: [PATCH 12/12] mmci: support variants with only one irq
In-Reply-To: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <AANLkTikuf7Br7oTfynrRQ2DW0Tiw3QvJL58sKZGBsF=3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:

> The Ux500 variants have only one IRQ line hooked up. ?Allow these to
> work by directing the PIO interrupts also to the first IRQ line.

I see this one is dangling in the patch tracker, FYI I have regression
tested this on the PB1176MPcore with its unmodified ARM PL180
MMCI block - read/write files copy mount/unmount - no problems.

Yours,
Linus Walleij
