From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 13 May 2015 19:37:49 +0200
Subject: [PATCH] ARM: BCM5301X: Fix chip typo in ARCH_BCM_5301X help
 message
In-Reply-To: <1431501645-3887-1-git-send-email-zajec5@gmail.com>
References: <1431501645-3887-1-git-send-email-zajec5@gmail.com>
Message-ID: <55538BED.4070504@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 09:20 AM, Rafa? Mi?ecki wrote:
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  arch/arm/mach-bcm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 8b11f44..7fec7e8 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -47,7 +47,7 @@ config ARCH_BCM_5301X
>  	  BCM53014, BCM53015, BCM53016, BCM53017, BCM53018, BCM4707,
>  	  BCM4708 and BCM4709.
>  
> -	  Do not confuse this with the BCM4760 which is a totally
> +	  Do not confuse this with the BCM4706 which is a totally
>  	  different SoC or with the older BCM47XX and BCM53XX based
>  	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
>  
> 
Nack

Like Florian said this is not a typo. There is a BCM4760 SoC and it was
or is supported by Linux.

See this for BCM4760: https://lwn.net/Articles/563957/

I forgot about this at first too. Nice naming Broadcom. (the other
companies are not better).  ;-)

Hauke
