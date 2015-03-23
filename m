From: gwenhael.goavec-merou@armadeus.com (gwenhael.goavec)
Date: Mon, 23 Mar 2015 11:40:29 +0100
Subject: [PATCH 1/2] ARM: dts: imx28-apf28dev: fix user button polarity
In-Reply-To: <1426086361-32933-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1426086361-32933-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20150323114029.302275ce@x230.trabucayre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping?

On Wed, 11 Mar 2015 16:06:00 +0100
Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com> wrote:

> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---
>  arch/arm/boot/dts/imx28-apf28dev.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index 81e5f75..1e72b0d 100644
> --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> @@ -223,7 +223,7 @@
>  
>  		user-button {
>  			label = "User button";
> -			gpios = <&gpio0 17 0>;
> +			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x100>;
>  		};
>  	};
> -- 
> 2.0.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
