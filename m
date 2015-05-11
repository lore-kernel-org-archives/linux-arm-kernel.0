From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 May 2015 08:01:29 +0200
Subject: Automatic clock disabling on clk_put()
Message-ID: <20150511060129.GG6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Since we now have per-user clks we could automatically disable clks on
clk_put() to make the drivers errors paths easier. AFAIR that was one
of the motivations to switch to per user clks. Is this just not yet
implemented or are there problems implementing this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
