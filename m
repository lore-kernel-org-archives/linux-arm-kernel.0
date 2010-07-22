From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 22 Jul 2010 18:22:50 +0900
Subject: [PATCH v4 4/7] ARM: S5P: Virtual Addresses for DMCx registers.
In-Reply-To: <1279790573-24179-4-git-send-email-myungjoo.ham@samsung.com>
References: <1279790573-24179-1-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-2-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-3-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-4-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279790573-24179-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	The CPUFREQ driver requires an access to DMCx registers. We
define virtual addresses of DMCx registers.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/include/plat/map-s5p.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 1482852..bd803f1 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -31,4 +31,7 @@
 #define VA_VIC2			VA_VIC(2)
 #define VA_VIC3			VA_VIC(3)
 
+#define S5P_VA_DMC0		S3C_ADDR(0x00a00000)
+#define S5P_VA_DMC1		S3C_ADDR(0x00b00000)
+
 #endif /* __ASM_PLAT_MAP_S5P_H */
-- 
1.6.3.3
