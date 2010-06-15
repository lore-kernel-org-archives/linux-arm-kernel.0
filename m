From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Tue, 15 Jun 2010 22:55:07 +0200
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTil7gb7SjrYPrHPfSomwxLlHpowXOZd_Qr125jvr@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<002001cb0c75$0a54fd00$1efef700$%kim@samsung.com>
	<AANLkTil7gb7SjrYPrHPfSomwxLlHpowXOZd_Qr125jvr@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025E5AE204@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Jassi]
> [Kukjin]
> >> It has been converted to use the header from the Samsung PL080
> >> derivate instead of its own defintions, and can potentially support
> >> several controllers in the same system.
> > Looks good, but please give me some time to test on the
> board(SMDK6410).
> > If any problem, let you know. Of course no problem, will ack.
> Samsung doesn't use the DMA API, so this driver is unlikely to work.

Yeah that was never the intention, the Samsung derivate has one extra
Register and other funny stuff.

I was more hoping on breaking out a subset in the same elegant way
with a generic part and a separate DMAengine as was done with the
PL330... But I need to get it fully working first.

Atleast I used the same include file.

But I have functional UART DMA on the RealView PB11MPCore now!

Yours,
Linus Walleij
