From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 05:39:04 +0200
Subject: [PATCH 1/4] GPMI-NAND: Define ecc.strength
In-Reply-To: <20120521034543.GD5810@S2100-06.ap.freescale.net>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <201205210440.09310.marex@denx.de>
 <20120521034543.GD5810@S2100-06.ap.freescale.net>
Message-ID: <201205210539.04277.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, May 21, 2012 at 04:40:09AM +0200, Marek Vasut wrote:
> > > So you are saying the issue is introduced by gpmi-nand DT conversion?
> > 
> > I doubt so ...
> 
> I can be very sure that you haven't looked at the gpmi-nand DT
> conversion patches at all.
> 
> The bug has been there since day one.  The commit cfbc855b (mtd: nand:
> add sanity check of ecc strength to nand_scan_tail()) added a BUG() to
> catch it recently.
> 
> So please at least spend some time to know the real cause before
> pointing your figure to DT conversion.

Well ... since noone was really able to test the patch, noone figured out it's 
broken. We can agree on that, right.

And btw. by "I doubt so ..." I means exactly that I doubt the bug was caused by 
the DT conversion.

Best regards,
Marek Vasut
