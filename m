From: marex@denx.de (Marek Vasut)
Date: Mon, 25 Jun 2012 18:01:22 +0200
Subject: [PATCH] mtd/m25p80: add device tree probe support
In-Reply-To: <20120625154006.GB2342@S2101-09.ap.freescale.net>
References: <1311601063-16581-1-git-send-email-shawn.guo@linaro.org>
 <201206230415.18833.marex@denx.de>
 <20120625154006.GB2342@S2101-09.ap.freescale.net>
Message-ID: <201206251801.22385.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sat, Jun 23, 2012 at 04:15:18AM +0200, Marek Vasut wrote:
> > So is there any particular reason why this wasn't applied?
> 
> Let me remind Artem by resending the patch tomorrow.

Actually ... the SPI does have the heuristics to probe this chip without the 
patch. But there was this discussion about them eventually being removed. That 
was a point raised by you I think. Is that still valid?

Best regards,
Marek Vasut
