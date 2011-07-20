From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 20 Jul 2011 22:44:53 +0200
Subject: [PATCH] arm/mxc: add the missing UART_PADDR for i.mx53
In-Reply-To: <20110720135921.GE6999@S2100-06.ap.freescale.net>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<1311167599-21790-1-git-send-email-shawn.guo@linaro.org>
	<20110720130830.GD2377@pengutronix.de>
	<20110720132418.GB6999@S2100-06.ap.freescale.net>
	<20110720132720.GE2377@pengutronix.de>
	<20110720134426.GD6999@S2100-06.ap.freescale.net>
	<20110720134530.GA15471@pengutronix.de>
	<20110720135921.GE6999@S2100-06.ap.freescale.net>
Message-ID: <20110720204453.GA5007@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 09:59:22PM +0800, Shawn Guo wrote:
> On Wed, Jul 20, 2011 at 03:45:30PM +0200, Wolfram Sang wrote:
> > On Wed, Jul 20, 2011 at 09:44:27PM +0800, Shawn Guo wrote:
> > > On Wed, Jul 20, 2011 at 03:27:20PM +0200, Wolfram Sang wrote:
> > > > > > Then you should at least add his Signed-off. And maybe also mark him as
> > > > > > the author of the patch?
> > > > > > 
> > > > > I did exactly what you suggested here on a mx53 fec patch, but I was
> > > > > told by Troy to change his s-o-b to reported-by.  So let's see what
> > > > > he would say about this one.
> > > > 
> > > > Okay, not much of a deal for such a patch. Though, I have doubts if one
> > > > can request removing the SoB for a patch other people put work on top
> > > > of.
> > > > 
> > > So you are telling you are not following the list closely?
> > 
> > If "following closely" == "reading every single mail", then surely not.
> > Why?
> > 
> Well, not really.  But since you are co-maintaining i.mx, I *thought*
> you may have read the mail with "i.mx" in the subject.  It seems not
> the case, apparently.

? I don't get the relevance to the topic, sorry.

If the new patch is different enough to be considered new, Troy could indeed
request his SoB to be removed. If his patch is mainly improved, I do still
wonder if he could request his SoB to be removed. That is possibly a gray area,
but as I said before, it really doesn't matter for this patch and is not worth
the fuzz here. Let's just go back to hacking :)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/063da325/attachment.sig>
