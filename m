From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 06 Sep 2013 13:50:05 -0700
Subject: [PATCH] ARM: msm: Remove irqs-*.h files for DT based targets
In-Reply-To: <1378499517-24014-1-git-send-email-sboyd@codeaurora.org>
References: <20130906195300.GJ808@joshc.qualcomm.com>
 <1378499517-24014-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <522A3FFD.9020105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/13 13:31, Stephen Boyd wrote:
> diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> index 905efc8..30b3342 100644
> --- a/arch/arm/mach-msm/Kconfig
> +++ b/arch/arm/mach-msm/Kconfig
> @@ -50,6 +50,7 @@ config ARCH_MSM8X60
>  	select HAVE_SMP
>  	select MSM_SCM if SMP
>  	select USE_OF
> +	select SPARSE_IRQ
>  
>  config ARCH_MSM8960
>  	bool "MSM8960"
> @@ -59,6 +60,7 @@ config ARCH_MSM8960
>  	select GPIO_MSM_V2
>  	select MSM_SCM if SMP
>  	select USE_OF
> +	select SPARSE_IRQ

Gah, I guess this needs to be sorted alphabetically.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
