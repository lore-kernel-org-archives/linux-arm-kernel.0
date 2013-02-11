From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Feb 2013 17:07:52 +0100
Subject: [PATCH 1/2] ARM: OMAP2+: Allow clock alias provision from device
 tree
In-Reply-To: <1360597464-8491-1-git-send-email-rogerq@ti.com>
References: <1360597464-8491-1-git-send-email-rogerq@ti.com>
Message-ID: <20130211160752.GG1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 05:44:23PM +0200, Roger Quadros wrote:
> Currently on OMAP, it is not possible to specify a clock consumer
> to any of the OMAP generated clocks using the device tree. This can pose
> a problem for external devices that run off an OMAP clock as we
> can't reliably provide a reference to the clock in the device tree.

There is an established way of providing clocks in the devicetree using
the clocks/clock-names properties. Wouldn't it be better using this
for OMAP aswell?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
