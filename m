From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Jul 2018 17:19:53 +0200
Subject: [PATCH] ARM: dts: sunxi: Remove unused address-cells/size-cells
 of dwmac-sun8i
In-Reply-To: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
References: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20180717151953.oab5tsurldmz4tjn@flea>
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
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 8 --------
>  arch/arm/boot/dts/sun8i-a83t.dtsi                     | 2 --
>  arch/arm/boot/dts/sun8i-r40.dtsi                      | 2 --
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                    | 2 --
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         | 2 --

Just saw this, and dropped the patch. Please provide separate patches
for the h3-h5 DTSI, the arm64 and arm patches.

And ideally for the binding.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/a820d658/attachment.sig>
