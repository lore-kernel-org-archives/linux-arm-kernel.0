From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 4 Jul 2012 14:05:00 +0200
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <201207041149.22941.arnd@arndb.de>
References: <20120704075116.GA29310@pengutronix.de>
 <201207041149.22941.arnd@arndb.de>
Message-ID: <20120704120500.GB30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 11:49:22AM +0000, Arnd Bergmann wrote:
> On Wednesday 04 July 2012, Sascha Hauer wrote:
> > Hi Arnd, Olof,
> > 
> > Please pull the following i.MX fixes for -rc
> > 
> 
> Thanks, pulled into the fixes branch. I plan to send out fixes tomorrow
> to Linus.
> 
> 
> > Uwe Kleine-K?nig (1):
> >       ARM: imx: assert SCC gate stays enabled
> 
> Is this something that should have been marked for stable, or was
> it just recently introduced? The description suggests the former.

The bug was introduced in the last merge window, so not suitable for
stable.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
