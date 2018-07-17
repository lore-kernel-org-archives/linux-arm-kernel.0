From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Jul 2018 17:18:55 +0200
Subject: [PATCH] ARM: dts: sunxi: Remove unused address-cells/size-cells
 of dwmac-sun8i
In-Reply-To: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
References: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20180717151855.wsz6om7uf3j6c7it@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2018 at 11:55:49AM +0000, Corentin Labbe wrote:
> address-cells/size-cells is unnecessary for dwmac-sun8i node.
> It was in early days, but since a mdio node is used, it could be
> removed.
> 
> This patch fix the following DT warning:
> Warning (avoid_unnecessary_addr_size): /soc/ethernet at 1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/1339cfbe/attachment.sig>
