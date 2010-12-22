From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 22 Dec 2010 22:17:24 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <20101222182041.GE14693@n2100.arm.linux.org.uk>
References: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
	<20101222141006.GA19852@n2100.arm.linux.org.uk>
	<AANLkTi=uhMyDySAxbZK4XKU6Z4AbkjVc29L4idc0sxLf@mail.gmail.com>
	<20101222182041.GE14693@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=ADSCbFZsOorL=tBAE=FLQC13uLyqRk4OgCXe3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> The PB926 doesn't specify whether it connects the burst or single-
> character DMA request signal to the DMA controller - from the behaviour
> I observe, I suspect it's the single character request which is.

Aha I suspect this is it... :-(

FYI I have repeatedly requested access to the PB926 board from
ARM but these can't even be bought any more, even if I had the
money. Thanks for testing at it!

Yours,
Linus Walleij
