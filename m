From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 27 Jun 2018 08:10:24 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: fix eth3 connector name
In-Reply-To: <e4bdd3c11db195ffccb1da7b62e489ed85a2bb1d.1529818097.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Sun, 24 Jun 2018 08:28:17 +0300")
References: <e4bdd3c11db195ffccb1da7b62e489ed85a2bb1d.1529818097.git.baruch@tkos.co.il>
Message-ID: <871scsahf3.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On dim., juin 24 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> The right most SFP connector on the Macchiatobin board and schematics is
> marked as CON13/CON14.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index a66958ff4de6..56fa44860909 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -91,7 +91,7 @@
>  	};
>  
>  	sfp_eth3: sfp-eth3 {
> -		/* CON3,4 - CPS lane 5 */
> +		/* CON13,14 - CPS lane 5 */
>  		compatible = "sff,sfp";
>  		i2c-bus = <&sfp_1g_i2c>;
>  		los-gpio = <&cp0_gpio2 22 GPIO_ACTIVE_HIGH>;
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
