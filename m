From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 29 Nov 2012 11:50:29 +0530
Subject: [PATCH 1/2] ARM: tegra: remove unused functions in mach/clk.h
In-Reply-To: <1353999553-5196-1-git-send-email-sivaramn@nvidia.com>
References: <1353999553-5196-1-git-send-email-sivaramn@nvidia.com>
Message-ID: <50B6FEAD.9070401@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 November 2012 12:29 PM, Sivaram Nair wrote:
> This is a cleaning up patch that removes couple of functions in
> mach/clk.h that are no longer used and does not have any body.
>
> Signed-off-by: Sivaram Nair <sivaramn@nvidia.com>
> ---
>   arch/arm/mach-tegra/include/mach/clk.h |    5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/include/mach/clk.h b/arch/arm/mach-tegra/include/mach/clk.h
> index 95f3a54..64d2657 100644
> --- a/arch/arm/mach-tegra/include/mach/clk.h
> +++ b/arch/arm/mach-tegra/include/mach/clk.h
> @@ -34,11 +34,6 @@ enum tegra_clk_ex_param {
>   void tegra_periph_reset_deassert(struct clk *c);
>   void tegra_periph_reset_assert(struct clk *c);
>   
> -#ifndef CONFIG_COMMON_CLK
> -unsigned long clk_get_rate_all_locked(struct clk *c);
> -#endif
> -
> -void tegra2_sdmmc_tap_delay(struct clk *c, int delay);
>   int tegra_clk_cfg_ex(struct clk *c, enum tegra_clk_ex_param p, u32 setting);
>   
>   #endif

Reviewed-by: Prashant Gaikwad <pgaikwad@nvidia.com>
