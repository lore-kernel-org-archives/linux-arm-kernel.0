From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 5 Jul 2018 11:41:00 +0200
Subject: [PATCH v2 0/5] arm64: allwinner: h6: Enable AXP805 PMIC on Pine
 H64
In-Reply-To: <20180705031106.344-1-wens@csie.org>
References: <20180705031106.344-1-wens@csie.org>
Message-ID: <20180705094100.ezydvbitowwe5pwf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 11:11:01AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series enables the AXP805 PMIC found on the Pine64 Pine H64 board.
> The AXP805 seems to be identical to the AXP806 when comparing datasheets.
> The Pine H64 uses the PMIC in stand-alone or "self-working" mode, using
> the I2C interface. Neither features are currently supported. This series
> adds support for them, and then adds the PMIC to the device tree.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180705/1539a556/attachment.sig>
