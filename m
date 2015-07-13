From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 13 Jul 2015 16:50:47 +0300
Subject: [PATCH V3 19/19] ARM: tegra: select PM_GENERIC_DOMAINS
In-Reply-To: <1436791197-32358-20-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-20-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150713135047.GR6287@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:57PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh@nvidia.com>
> 
> We have added generic power domain support for Tegra SoCs. So now the
> option M_GENERIC_DOMAINS must be enabled by default to have proper power

Missing P :)

> sequence.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-tegra/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 0fa4c5f8b1be..fdf86cae3b32 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -9,6 +9,7 @@ menuconfig ARCH_TEGRA
>  	select HAVE_ARM_TWD if SMP
>  	select PINCTRL
>  	select PM_OPP
> +	select PM_GENERIC_DOMAINS if PM
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
>  	select SOC_BUS
> -- 
> 2.1.4
> 
