From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 06 Dec 2011 14:43:15 +0530
Subject: [PATCH v2 1/3] ARM: EXYNOS: Add USB OHCI device
In-Reply-To: <001301ccb3e0$b5fec280$21fc4780$%han@samsung.com>
References: <001101ccb3e0$7fe48270$7fad8750$%han@samsung.com>
 <001301ccb3e0$b5fec280$21fc4780$%han@samsung.com>
Message-ID: <4EDDDCAB.1000001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 December 2011 12:01 PM, Jingoo Han wrote:
> This patch adds USB ohci device definition for Exynos SoCs.
>
> Signed-off-by: Jingoo Han<jg1.han@samsung.com>
> ---
>   arch/arm/mach-exynos/Kconfig              |    5 +++
>   arch/arm/mach-exynos/Makefile             |    1 +
>   arch/arm/mach-exynos/dev-ohci.c           |   52 +++++++++++++++++++++++++++++
>   arch/arm/mach-exynos/include/mach/map.h   |    1 +
>   arch/arm/mach-exynos/include/mach/ohci.h  |   21 +++++++++++

In the earlier patchset, platform_device struct for ohci was defined 
within plat-samsung, and ohci.h was located in 
plat-samsung/include/plat. These are still the locations where ehci 
related definitions are located.

What is the reason for movement of ohci related definitions to mach folder?

-- 
Tushar Behera
