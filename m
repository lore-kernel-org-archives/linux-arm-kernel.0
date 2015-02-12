From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Feb 2015 11:02:08 +0000
Subject: [PATCH v3 1/8] arm64: exynos5433: Enable ARMv8 based Exynos5433
 (SoC) support
In-Reply-To: <1423724158-23632-2-git-send-email-cw00.choi@samsung.com>
References: <1423724158-23632-1-git-send-email-cw00.choi@samsung.com>
 <1423724158-23632-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20150212110208.GB1028@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 03:55:51PM +0900, Chanwoo Choi wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 15e8e74..4fc08d1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -153,6 +153,19 @@ config ARCH_EXYNOS
>  	help
>  	  This enables support for Samsung Exynos SoC family
>  
> +config ARCH_EXYNOS5433
> +	bool "ARMv8 based Samsung Exynos5433"
> +	select ARCH_EXYNOS
> +	select ARM_AMBA
> +	select ARM_GIC

ARM_GIC and ARM_AMBA are already selected by the top ARM64 config.

-- 
Catalin
