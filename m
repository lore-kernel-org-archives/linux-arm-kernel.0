From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 28 Oct 2010 01:44:13 +0200
Subject: [PATCH] ARM: imx: Add some core definitions for MX53
In-Reply-To: <20101027132213.GJ6017@pengutronix.de>
References: <1288119235-7036-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101027082958.GA6797@angua.secretlab.ca>
	<20101027090921.GB8554@pengutronix.de>
	<20101027102253.GA7822@angua.secretlab.ca>
	<20101027132213.GJ6017@pengutronix.de>
Message-ID: <20101027234413.GD32583@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 03:22:13PM +0200, Sascha Hauer wrote:
> That's a way we can go but only if the common name is not MX5 or MX5x.
> We've done it with the mx21/27 and it failed when the mx25 came out
> which was completely incompatible.

And even worse, there is also the MX23 and MX28 in the meantime which
are not i.MX at all: they are a design coming from Sigmatel, bought by
Freescale and only named i.MX due to marketing reasons.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
