From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 22 Jul 2013 18:57:07 +0200
Subject: [PATCH 04/22] ARM: at91: dt: Remove '0x's from Animeo IP DTS file
In-Reply-To: <1374490361-25769-4-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20130722165707.GJ16015@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:52 Mon 22 Jul     , Lee Jones wrote:
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/animeo_ip.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
> index 3a1de9e..4cb0342 100644
> --- a/arch/arm/boot/dts/animeo_ip.dts
> +++ b/arch/arm/boot/dts/animeo_ip.dts
> @@ -105,7 +105,7 @@
>  				reg = <0x48000 0x8000>;
>  			};
>  
> -			user_block at 0x50000 {
> +			user_block at 50000 {
>  				label = "user_block";
>  				reg = <0x50000 0xb0000>;
>  			};
> -- 
> 1.8.1.2
> 
