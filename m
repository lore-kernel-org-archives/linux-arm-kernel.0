From: horms@verge.net.au (Simon Horman)
Date: Wed, 6 Aug 2014 09:54:59 +0900
Subject: [PATCH] ARM: shmobile: Remove genmai_defconfig from MAINTAINERS
In-Reply-To: <1407135108-3371-1-git-send-email-horms+renesas@verge.net.au>
References: <1407135108-3371-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140806005459.GB5611@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 03:51:48PM +0900, Simon Horman wrote:
> The genmai defconfig file has been removed by
> 3ed27bd90d6d0c8b ("ARM: shmobile: genmai: remove defconfig")
> so remove its entry in the MAINTAINERS accordingly.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up for v3.18.

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86efa7e..6fb61a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1320,7 +1320,6 @@ F:	arch/arm/boot/dts/sh*
>  F:	arch/arm/configs/ape6evm_defconfig
>  F:	arch/arm/configs/armadillo800eva_defconfig
>  F:	arch/arm/configs/bockw_defconfig
> -F:	arch/arm/configs/genmai_defconfig
>  F:	arch/arm/configs/koelsch_defconfig
>  F:	arch/arm/configs/kzm9g_defconfig
>  F:	arch/arm/configs/lager_defconfig
> -- 
> 2.0.1
> 
