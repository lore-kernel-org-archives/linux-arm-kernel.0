From: horms@verge.net.au (Simon Horman)
Date: Fri, 22 Aug 2014 10:40:27 +0900
Subject: [PATCH] ARM: shmobile: bockw: Do not disable SUSPEND in defconfig
In-Reply-To: <1408052188-8551-1-git-send-email-horms+renesas@verge.net.au>
References: <1408052188-8551-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140822014027.GA9099@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 06:36:28AM +0900, Simon Horman wrote:
> As of "ARM: shmobile: r8a7778: Add missing call to shmobile_init_late()"
> suspend-to-ram is now supported on the r8a7778 SoC and thus the bockw
> board.
> 
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.

> ---
>  arch/arm/configs/bockw_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
> index 70b3f45..1dde5da 100644
> --- a/arch/arm/configs/bockw_defconfig
> +++ b/arch/arm/configs/bockw_defconfig
> @@ -29,7 +29,6 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_VFP=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> -# CONFIG_SUSPEND is not set
>  CONFIG_PM_RUNTIME=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> -- 
> 2.0.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
