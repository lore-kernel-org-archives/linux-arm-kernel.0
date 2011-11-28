From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 28 Nov 2011 09:17:41 +0100
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <35AB98346D25394A9354ED89C4D76587225E7D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111128070821.GD3869@pengutronix.de>
 <35AB98346D25394A9354ED89C4D76587225E7D@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111128081741.GH3869@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 08:10:14AM +0000, Chen Peter-B29397 wrote:
> > - help to mainline Heikki's patches (port your platform, help testing)
> > - let's improve the ci13xxx driver for i.MX.
>
> Robert, thanks for your suggestion, I just wonder if it will cause
> mx28 usb upstream a little later?

Well, if the quality of the code improves, it will be worth it. Note
that this is already unmaintainable: if you don't believe it, look at
the git log for the four different drivers and you'll notice that a lot
of bugs and improvements do not make their way into all of the drivers.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
