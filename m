From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Thu, 28 Jun 2012 14:08:35 +0200
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628114108.GD22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
 <20120628112111.GC22990@S2101-09.ap.freescale.net>
 <4FEC400F.8010506@pengutronix.de>
 <20120628114108.GD22990@S2101-09.ap.freescale.net>
Message-ID: <20120628120835.GA3402@vandijck-laurijssen.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 07:41:10PM +0800, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
> > I mean which name is more precise, do these gpio enable/standy a "phy"
> > or a "transceiver". For example:
> > http://www.nxp.com/documents/application_note/AN00094.pdf, this document
> > says: TJA1041/1041A high speed CAN transceiver.
> > 
> Isn't term "phy" (physical interface) generally meant to be the same
> thing as "transceiver"?  I just happened to like the shorter one as
> what Hui did in his patch.

'trx' seemed the right abbreviation
http://www.acronymfinder.com/TRX.html

thanks to Oliver, in his email on May 9th.

Kurt
