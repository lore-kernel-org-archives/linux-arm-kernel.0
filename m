From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 17 Nov 2011 10:29:46 +0100
Subject: [PATCH] arm: mx28: check for gated clocks when setting saif
 divider
In-Reply-To: <20111117011833.GD14656@S2100-06.ap.freescale.net>
References: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
 <20111116132222.GD2596@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722D4E65@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111116135125.GE2596@pengutronix.de>
 <20111117011833.GD14656@S2100-06.ap.freescale.net>
Message-ID: <20111117092946.GA2535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I chose this approach because this is the common pattern
> > in all other clocks. There might be a better way of handling this, but
> > then we'd need to adapt all other clocks as well. What we definately
> > should not have is one kind of handling the 'already enabled' case for a
> > few clocks and another kind for others.
> > 
> What about leaving it as it is for now, and try to consolidate when
> we rework the code for common clock framework migration?

In general, very fine with me. I seem to recall saif-drivers will need a
hack then, but Aisheng surely knows better.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111117/454a0c31/attachment.sig>
