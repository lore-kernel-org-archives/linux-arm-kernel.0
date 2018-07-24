From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 10:44:47 +0200
Subject: [PATCH] mmc: sunxi: allow 3.3V DDR when DDR is available
In-Reply-To: <20180722125407.43107-1-icenowy@aosc.io>
References: <20180722125407.43107-1-icenowy@aosc.io>
Message-ID: <20180724084447.bbqxchp5yamzc54i@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 08:54:07PM +0800, Icenowy Zheng wrote:
> Some Allwinner boards feature an on-board eMMC with fixed 3.3V voltage
> (e.g. Banana Pi M2+), and in this case both the eMMC and the SoC are
> capable of doing 3.3V DDR transmission.
> 
> Add capability of 3.3V DDR when DDR is available (extra clock or new
> timing).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/a598348e/attachment.sig>
