From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 2 May 2018 13:34:13 +0200
Subject: [PATCH 09/21] arm64: dts: allwinner: a64: Add HDMI support
In-Reply-To: <20180430114058.5061-10-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com>
Message-ID: <20180502113413.vv2r3ubfoh7gm3ms@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
> +		hdmi_phy: hdmi-phy at 1ef0000 {
> +			compatible = "allwinner,sun50i-a64-hdmi-phy",
> +				     "allwinner,sun8i-h3-hdmi-phy";
> +			reg = <0x01ef0000 0x10000>;
> +			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> +				 <&ccu CLK_PLL_VIDEO1>;

You were discussing that the PLL0 could also be used to clock the PHY,
has that been figured out?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/23bce7a7/attachment.sig>
