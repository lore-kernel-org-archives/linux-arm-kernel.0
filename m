From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Aug 2012 15:48:40 +0900
Subject: [PATCH 05/11] ARM: exynos: exynos_pm_add_dev_to_genpd may be
 unused
In-Reply-To: <1344437248-20560-6-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-6-git-send-email-arnd@arndb.de>
Message-ID: <0de601cd76c4$2d5846c0$8808d440$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> exynos_pm_add_dev_to_genpd is used if one or more out of a large
> number of Kconfig symbols are enabled. However the new
> exynos_defconfig selects none of those, so the function becomes
> unused. Marking it so lets the compiler automatically discard
> it.
> 
> Without this patch, building exynos_defconfig results in:
> 
> arch/arm/mach-exynos/pm_domains.c:118:123: warning:
> 'exynos_pm_add_dev_to_genpd' defined but not used [-Wunused-function]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
