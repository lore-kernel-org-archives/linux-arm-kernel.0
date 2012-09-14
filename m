From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Sep 2012 13:33:34 +0900
Subject: [PATCH v9 05/13] ARM: SoC: convert Exynos4 to SoC descriptor
In-Reply-To: <1347461906-13527-6-git-send-email-arnd@arndb.de>
References: <1347461906-13527-1-git-send-email-arnd@arndb.de>
 <1347461906-13527-6-git-send-email-arnd@arndb.de>
Message-ID: <01ae01cd9232$19d78ff0$4d86afd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Convert Exynos4 to use the SoC descriptor to provide its SMP
> and CPU hotplug operations.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Tested-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-exynos/common.h              |    5 +++++
>  arch/arm/mach-exynos/hotplug.c             |   18 +++---------------
>  arch/arm/mach-exynos/mach-armlex4210.c     |    1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c     |    1 +
>  arch/arm/mach-exynos/mach-nuri.c           |    1 +
>  arch/arm/mach-exynos/mach-origen.c         |    1 +
>  arch/arm/mach-exynos/mach-smdk4x12.c       |    2 ++
>  arch/arm/mach-exynos/mach-smdkv310.c       |    2 ++
>  arch/arm/mach-exynos/mach-universal_c210.c |    1 +
>  arch/arm/mach-exynos/platsmp.c             |   20 ++++++++++++++++----
>  10 files changed, 33 insertions(+), 19 deletions(-)
