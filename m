From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 17 Feb 2012 12:16:37 +0100
Subject: [GIT PULL] i.MX assorted
In-Reply-To: <CAOMZO5CnLksYpXjW2FP-NAqRFVrOADKc5L_XUY8cBe-g6UpitA@mail.gmail.com>
References: <20120217082426.GO3852@pengutronix.de>
 <CAOMZO5CnLksYpXjW2FP-NAqRFVrOADKc5L_XUY8cBe-g6UpitA@mail.gmail.com>
Message-ID: <20120217111637.GT3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 09:10:30AM -0200, Fabio Estevam wrote:
> On Fri, Feb 17, 2012 at 6:24 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > ----------------------------------------------------------------
> > Fabio Estevam (7):
> > ? ? ?ARM: mach-pcm038: Fix field name of regulator_consumer_supply struct
> 
> This one fixes a build breakage in mainline, so it would be nice if
> this one could be pulled first.

This breaks since

regulator: Remove support for supplies specified by struct device

currently sitting in next. Linus master builds fine.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
