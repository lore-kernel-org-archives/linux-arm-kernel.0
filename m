From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Aug 2012 14:41:28 +0200
Subject: [PATCH] arm: dts: remove partial parameter in at91sam9g25ek.dts
In-Reply-To: <1345191836-16523-1-git-send-email-voice.shen@atmel.com>
References: <1345191836-16523-1-git-send-email-voice.shen@atmel.com>
Message-ID: <503624F8.4070906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2012 10:23 AM, Bo Shen :
> Remove the partial parameter in at91sam9g25ek.dts file
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Included in at91-fixes for 3.6: thanks a lot.

> ---
>  arch/arm/boot/dts/at91sam9g25ek.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
> index 7829a4d..96514c1 100644
> --- a/arch/arm/boot/dts/at91sam9g25ek.dts
> +++ b/arch/arm/boot/dts/at91sam9g25ek.dts
> @@ -15,7 +15,7 @@
>  	compatible = "atmel,at91sam9g25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
>  
>  	chosen {
> -		bootargs = "128M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
> +		bootargs = "console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
>  	};
>  
>  	ahb {
> 


-- 
Nicolas Ferre
