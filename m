From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Dec 2009 12:03:08 +0100
Subject: [RFC][PATCH 05/10] mxc: Add board support for the i.MX51
	babbage board
In-Reply-To: <0559d42bc9f32e30264fea6ca6fa679121f6a241.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<0559d42bc9f32e30264fea6ca6fa679121f6a241.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <20091204110308.GK15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 04:47:05AM +0200, Amit Kucheria wrote:
> Add basic clock support, cpu identification, I/O mapping and serial port. Boot
> tested on Freescale Babbage 2.5 board.

Can you split this into two patches, one for the i.MX51 support and one
for the babbage board?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
