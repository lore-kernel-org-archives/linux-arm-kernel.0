From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 May 2010 11:36:52 +0200
Subject: i.MX EHCI initialization
Message-ID: <20100517093652.GP31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Daniel et all,

I see an increasing number of patches trying to change the
initialization sequence of the i.MX ehci controller. It's getting harder
and harder to keep track what the changes are, what other boards
and SoCs a single patch affects and whether it just reverts another
patch.

I thought about making the initialization completely board specific and
creating a set of helper functions which the board can call if it wants
to to prevent too much code duplication.

What do you think?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
