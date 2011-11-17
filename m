From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Nov 2011 09:12:27 +0800
Subject: [PATCH] arm: mx28: fix bit operation in clock setting
In-Reply-To: <20111116132041.GC2596@pengutronix.de>
References: <1315650367-3371-1-git-send-email-w.sang@pengutronix.de>
 <20111116132041.GC2596@pengutronix.de>
Message-ID: <20111117011225.GC14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 02:20:42PM +0100, Wolfram Sang wrote:
> On Sat, Sep 10, 2011 at 12:26:07PM +0200, Wolfram Sang wrote:
> > reg | (1 << clk->enable_shift) always evaluates to true. Switch it
> > to & which makes much more sense. Same fix as 13be9f00 (ARM i.MX28: fix
> > bit operation) at a different location.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > ---
> 
> Ping.
> 
Applied on mxs/fixes, thanks.

-- 
Regards,
Shawn
