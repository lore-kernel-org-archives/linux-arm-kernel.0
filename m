From: horms@verge.net.au (Simon Horman)
Date: Mon, 29 Oct 2018 11:20:54 +0100
Subject: [PATCH] arm64: defconfig: Enable R-Car thermal driver
In-Reply-To: <20181017100718.29429-1-horms+renesas@verge.net.au>
References: <20181017100718.29429-1-horms+renesas@verge.net.au>
Message-ID: <20181029102054.4zaxtszvj5bo3hrc@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 12:07:18PM +0200, Simon Horman wrote:
> Enable the R-Car thermal driver as a module.
> 
> This driver is used in conjunction with the R-Car V3M (r8a77970),
> E3 (r8a77990) and D3 (r8a77995) SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied for v4.21.

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e6ec9858d33d..205d212eac58 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -365,6 +365,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_THERMAL_EMULATION=y
>  CONFIG_ROCKCHIP_THERMAL=m
> +CONFIG_RCAR_THERMAL=m
>  CONFIG_RCAR_GEN3_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
>  CONFIG_BRCMSTB_THERMAL=m
> -- 
> 2.11.0
> 
