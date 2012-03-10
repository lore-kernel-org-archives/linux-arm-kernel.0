From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 10 Mar 2012 02:19:09 -0800
Subject: [PATCH 5/5] ARM: EXYNOS: add clock registers for exynos4x12-cpufreq
In-Reply-To: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
References: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331374749-23256-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/include/mach/regs-clock.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index 790f525..b1a2aeb 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -160,6 +160,15 @@
 #define EXYNOS4_CLKDIV_CPU0_PCLKDBG_MASK	(0x7 << EXYNOS4_CLKDIV_CPU0_PCLKDBG_SHIFT)
 #define EXYNOS4_CLKDIV_CPU0_APLL_SHIFT		(24)
 #define EXYNOS4_CLKDIV_CPU0_APLL_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_APLL_SHIFT)
+#define EXYNOS4_CLKDIV_CPU0_CORE2_SHIFT		28
+#define EXYNOS4_CLKDIV_CPU0_CORE2_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_CORE2_SHIFT)
+
+#define EXYNOS4_CLKDIV_CPU1_COPY_SHIFT		0
+#define EXYNOS4_CLKDIV_CPU1_COPY_MASK		(0x7 << EXYNOS4_CLKDIV_CPU1_COPY_SHIFT)
+#define EXYNOS4_CLKDIV_CPU1_HPM_SHIFT		4
+#define EXYNOS4_CLKDIV_CPU1_HPM_MASK		(0x7 << EXYNOS4_CLKDIV_CPU1_HPM_SHIFT)
+#define EXYNOS4_CLKDIV_CPU1_CORES_SHIFT		8
+#define EXYNOS4_CLKDIV_CPU1_CORES_MASK		(0x7 << EXYNOS4_CLKDIV_CPU1_CORES_SHIFT)
 
 #define EXYNOS4_CLKDIV_DMC0_ACP_SHIFT		(0)
 #define EXYNOS4_CLKDIV_DMC0_ACP_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_ACP_SHIFT)
-- 
1.7.4.4
