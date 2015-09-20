From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 20 Sep 2015 21:06:52 +0200
Subject: [PATCH 1/3] arm64: berlin: enable ARCH_REQUIRE_GPIOLIB
In-Reply-To: <1442584059-7319-2-git-send-email-jszhang@marvell.com>
References: <1442584059-7319-1-git-send-email-jszhang@marvell.com>
 <1442584059-7319-2-git-send-email-jszhang@marvell.com>
Message-ID: <55FF03CC.7020001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.09.2015 15:47, Jisheng Zhang wrote:
> All berlin SoCs have GPIOs driven by the dwapb GPIO driver. Add GPIOLIB
> as a dependency to be able to support them.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to berlin64/soc.

Thanks,
   Sebastian

> ---
>   arch/arm64/Kconfig.platforms | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 23800a1..c6e2c75 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -7,6 +7,7 @@ config ARCH_BCM_IPROC
>
>   config ARCH_BERLIN
>   	bool "Marvell Berlin SoC Family"
> +	select ARCH_REQUIRE_GPIOLIB
>   	select DW_APB_ICTL
>   	help
>   	  This enables support for Marvell Berlin SoC Family
>
