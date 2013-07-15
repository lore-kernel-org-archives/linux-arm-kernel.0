From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 23:20:52 +0200
Subject: [PATCH 06/22] arm/dts: i.MX25: Add ssi clocks and DMA events.
In-Reply-To: <1373900227-341-7-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-7-git-send-email-denis@eukrea.com>
Message-ID: <20130715212052.GC10995@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:56:51PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx25.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index b318106..fb37111 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -293,6 +293,9 @@
>  				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
>  				reg = <0x50014000 0x4000>;
>  				interrupts = <11>;
> +				clocks = <&clks 118>;
> +				clock-names = "ssi2_ipg";

ssi2_ipg is wrong. This should be "ipg".

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
