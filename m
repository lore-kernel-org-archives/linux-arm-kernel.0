From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 7 Dec 2017 18:12:31 +0100
Subject: [PATCH] ARM: dts: imx6: RDU2: correct RTC compatible
In-Reply-To: <20171207150923.25024-1-l.stach@pengutronix.de>
References: <20171207150923.25024-1-l.stach@pengutronix.de>
Message-ID: <20171207171231.GX21780@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2017 at 16:09:23 +0100, Lucas Stach wrote:
> The RTC is manufactured by Maxim. This is a cosmetic fix, as Linux
> doesn't match the vendor string for i2c devices.
> 

Actually, it does, see da10c06a044b3752f9162a88b7d26ed2409c5314.

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index eef737bd52d9..6bef9a98678e 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -581,7 +581,7 @@
>  	};
>  
>  	ds1341: rtc at 68 {
> -		compatible = "dallas,ds1341";
> +		compatible = "maxim,ds1341";
>  		reg = <0x68>;
>  	};
>  };
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
