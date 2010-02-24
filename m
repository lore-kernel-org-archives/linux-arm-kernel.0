From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Feb 2010 21:10:34 +0100
Subject: [PATCH 3/7] ARM: U300: set f_max to 24 MHz for MMCI
In-Reply-To: <20100224144054.GA21680@n2100.arm.linux.org.uk>
References: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
	<20100221210740.GA3528@n2100.arm.linux.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E9355A2@eseldmw101.eemea.ericsson.se>
	<20100224125002.GA19641@n2100.arm.linux.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E963F15@eseldmw101.eemea.ericsson.se>
	<20100224144054.GA21680@n2100.arm.linux.org.uk>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E9641BA@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Russell]

> Versatile and Realview both have DMA infrastructure based around the
> PL080 and a routing selector for the DMA signals.  However, no one
> has yet come up with a suitable way to deal with this yet...

OK if there is anything more I can do to improve the example
with PL180 + DMA engine and the extra interface from <linux/amba/dma.h>
I'm willing to give it a spin. I don't have a RealView/Versatile readily
available so sadly I cannot experiment on these (and they're not
cheap either, I'm told, so it's not like I could walk over to
the shopping mall and buy one).

I can try to make a PL011 and/or PL022 DMA extension as well just as
an extended proof of concept, would this help?

Yours,
Linus Walleij
