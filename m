From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Oct 2009 10:21:08 +0200
Subject: usb support for imx35 ?
In-Reply-To: <200910201155.54578.a.babich@rez.ru>
References: <200910201155.54578.a.babich@rez.ru>
Message-ID: <20091020082108.GP8818@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 11:55:54AM +0600, Alexei Babich wrote:
> Hello all.
> 
> Tell me please, what is the status of support for USB-HOST in the microcontroller Freescale imx35?
> Thank you.

Basically the same status as for i.MX27/31/25. There have been patches
to add USB host support from Daniel Mack. Hopefully they go in in the
next merge window.
All mentioned i.MXs have the same otg core with some minor differences.
Daniels patches aim for i.MX31, but once these are mainline, the rest is
easy.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
