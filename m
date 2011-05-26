From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 May 2011 09:15:25 +0200
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <20110526043344.GA2749@acer>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
	<20110525195413.GC2996@acer>
	<BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com>
	<20110526043344.GA2749@acer>
Message-ID: <BANLkTikzrXRmdnv_v_nmJw7Nvsr6TY-5RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 6:33 AM, Mika Westerberg <mika.westerberg@iki.fi> wrote:

> Do you think that we can go forward with this patch series if I drop the last
> patch (spi/ep93xx: add DMA support)? This way we will have dmaengine
> implementation in place, whatever SPI driver we choose to use with ep93xx.

Yes and you don't have to drop any DMA support for the existing driver
for me alone, now that it's in the tree it should be maintained. I only
wanted to raise the issue of code duplication, not block any patches.

> We can then try to use amba-pl022 driver with ep93xx and see if it works or
> not, and how much work is needed. I would like some comments from Hartley and
> Ryan also.

Sure.

Thanks,
Linus Walleij
