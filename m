From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 23:21:45 +0800
Subject: [PATCH] ARM: mxs: read correct values when setting up MAC
In-Reply-To: <20120131142155.GQ2471@pengutronix.de>
References: <1327431447-5031-1-git-send-email-w.sang@pengutronix.de>
 <20120131142155.GQ2471@pengutronix.de>
Message-ID: <20120131152143.GC26436@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 03:21:55PM +0100, Wolfram Sang wrote:
> On Tue, Jan 24, 2012 at 07:57:27PM +0100, Wolfram Sang wrote:
> > Currently, the MAC address from the second ethernet is generated from the
> > crypto-key (and not a customer reg) because of a wrong index to the ocotp
> > array.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > ---
> 
> Ping.
> 
Just applied, thanks.

-- 
Regards,
Shawn
