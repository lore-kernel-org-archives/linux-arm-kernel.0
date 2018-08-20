From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 16:18:10 +0200
Subject: [PATCH] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to
 MMC module clocks
In-Reply-To: <20180820134013.16527-1-icenowy@aosc.io>
References: <20180820134013.16527-1-icenowy@aosc.io>
Message-ID: <20180820141810.botskv2xkzpnd5t3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 09:40:13PM +0800, Icenowy Zheng wrote:
> On the H6, the MMC module clocks are fixed in the new timing mode,
> i.e. they do not have a bit to select the mode. These clocks have
> a 2x divider somewhere between the clock and the MMC module.
> 
> To be consistent with other SoCs supporting the new timing mode,
> we model the 2x divider as a fixed post-divider on the MMC module
> clocks.
> 
> This patch adds the post-dividers to the MMC clocks, following the
> approach on A64.
> 
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/25b5fb99/attachment.sig>
