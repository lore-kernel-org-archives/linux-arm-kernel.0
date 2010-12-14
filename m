From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Dec 2010 11:46:56 +0100
Subject: [PATCH 19/24] ARM: mxc: update clock source registration
In-Reply-To: <E1PSDxe-0008DW-FL@rmk-PC.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDxe-0008DW-FL@rmk-PC.arm.linux.org.uk>
Message-ID: <20101214104656.GB29833@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 07:21:26PM +0000, Russell King - ARM Linux wrote:
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
