From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 00:15:08 +0800
Subject: [PATCH] mtd/m25p80: add device tree probe support
In-Reply-To: <201206251801.22385.marex@denx.de>
References: <1311601063-16581-1-git-send-email-shawn.guo@linaro.org>
 <201206230415.18833.marex@denx.de>
 <20120625154006.GB2342@S2101-09.ap.freescale.net>
 <201206251801.22385.marex@denx.de>
Message-ID: <20120625161506.GH2342@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 06:01:22PM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Sat, Jun 23, 2012 at 04:15:18AM +0200, Marek Vasut wrote:
> > > So is there any particular reason why this wasn't applied?
> > 
> > Let me remind Artem by resending the patch tomorrow.
> 
> Actually ... the SPI does have the heuristics to probe this chip without the 
> patch. But there was this discussion about them eventually being removed. That 
> was a point raised by you I think. Is that still valid?
> 
That was a point raised by Grant.  IIRC, the reason I made the patch
is my system does not probe the device without the patch.  I can
retest, and if it's true that the patch is not necessarily needed,
I will probably let it be.

-- 
Regards,
Shawn
