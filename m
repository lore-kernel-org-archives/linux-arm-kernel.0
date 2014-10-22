From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 15:11:27 +0100
Subject: [PATCH 7/7] ARM: mvebu: Enable perf support in mvebu_v7_defconfig
In-Reply-To: <1413985427-20918-8-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-8-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141022141127.GN22642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 02:43:47PM +0100, Ezequiel Garcia wrote:
> Now that Armada 375/38x have support for the PMU, this commit enables perf
> events in the defconfig.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index ed0a0d1..d1a4669 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -5,6 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> +CONFIG_PERF_EVENTS=y

Isn't this provided by CONFIG_ARM already?

Surely you want CONFIG_HW_PERF_EVENTS?

Thanks,
Mark.

>  CONFIG_SLAB=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
