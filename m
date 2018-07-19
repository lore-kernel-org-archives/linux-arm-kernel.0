From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Jul 2018 16:33:48 +0200
Subject: [PATCH v2 0/5] ARM: dts: sunxi: Remove unused
 address-cells/size-cells of dwmac-sun8i
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20180719143348.5kx24tr6k7ytywsk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 11:40:36AM +0000, Corentin Labbe wrote:
> address-cells/size-cells is unnecessary for dwmac-sun8i node.
> It was in early days, but since a mdio node is used, it could be
> removed.
>
> This patch fix the following DT warning:
> Warning (avoid_unnecessary_addr_size): /soc/ethernet at 1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/fb156578/attachment.sig>
