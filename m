From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 31 Jan 2013 16:12:35 +0100
Subject: [RFC 1/3] net: freescale: fec: add support for optional
 enet_out clk
In-Reply-To: <20130130052547.GA23670@S2100-06.ap.freescale.net>
References: <1359470773-14290-1-git-send-email-w.sang@pengutronix.de>
 <1359470773-14290-2-git-send-email-w.sang@pengutronix.de>
 <20130130052547.GA23670@S2100-06.ap.freescale.net>
Message-ID: <20130131151235.GC3400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 01:25:50PM +0800, Shawn Guo wrote:
> Thanks for working on this, Wolfram.
> 
> On Tue, Jan 29, 2013 at 03:46:11PM +0100, Wolfram Sang wrote:
> > Some MX28 boards need the internal enet_out clock to be enabled. So, do
> > this in the driver iff the clock was referenced via devicetree.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> > ---
> > 
> > davidm: Please don't apply before Shawn as the mxs-maintainer has given his ack
> > on the general procedure. Or maybe he can merge it via his tree?
> > 
> I prefer to have the patch go via net tree for 3.9, and then we clean
> up mxs platform code from 3.9-rc1.

Fine with me, too.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/57a58704/attachment.sig>
