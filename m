From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jan 2010 11:21:39 +0900
Subject: [PATCH] ARM: S5P6440: Add IO descriptor for ChipID block.
Message-ID: <1263867699-28672-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the IO descriptor for ChipID block in S5P6440.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/include/mach/map.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index b370329..dc922d6 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -15,6 +15,11 @@
 
 #include <plat/map-base.h>
 
+/* Chip ID */
+#define S5P6440_PA_CHIPID	(0xE0000000)
+#define S5P_PA_CHIPID		S5P6440_PA_CHIPID
+#define S5P_VA_CHIPID		S3C_ADDR(0x00700000)
+
 /* SYSCON */
 #define S5P6440_PA_SYSCON	(0xE0100000)
 #define S5P_PA_SYSCON		S5P6440_PA_SYSCON
-- 
1.6.2.5
