From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 09:37:00 +0200
Subject: [PATCH v2 04/18] arm64: dts: allwinner: a64: Orange Pi Win: Fix
 USB
In-Reply-To: <20180726003532.18751-5-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-5-andre.przywara@arm.com>
Message-ID: <20180726073700.urcau62aaeavo76e@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:35:18AM +0100, Andre Przywara wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> The Orange Pi Win has 5 USB ports:
> Four are standard A sockets, connected to an on-board HUB. The hub's and
> socket's power regulators are enabled by GPIO PD7.
> Also it features a microB socket, connected to the SoC's USB-OTG port.
> It's power is supplied by the AXP PMIC, and the ID pin is connected to
> GPIO PH9. It can serve both as a host or a client port.

Again, "Fix USB" is way too dramatic for something that enables the
on-board hub and the USB OTG controller.

Also, two separate patches for this please.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/6f810f70/attachment.sig>
