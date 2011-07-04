From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon,  4 Jul 2011 10:41:46 +0900
Subject: [PATCH 5/6] ARM: EXYNOS4: SYSMMU: Add SYSMMU_NONE
In-Reply-To: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
References: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1309743708-1505-6-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added new value 'SYSMMU_NONE' to sysmmu_ips.
This value represents invalid System MMU.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/sysmmu.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/sysmmu.h b/arch/arm/mach-exynos4/include/mach/sysmmu.h
index 2d5d78b..05e282c 100644
--- a/arch/arm/mach-exynos4/include/mach/sysmmu.h
+++ b/arch/arm/mach-exynos4/include/mach/sysmmu.h
@@ -33,6 +33,7 @@ enum exynos4_sysmmu_ips {
 };
 
 #define S5P_SYSMMU_TOTAL_IPNUM		EXYNOS4_SYSMMU_TOTAL_IPNUM
+#define SYSMMU_NONE			S5P_SYSMMU_TOTAL_IPNUM
 
 extern const char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM];
 
-- 
1.7.1
