From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 16:08:08 +0100
Subject: [PATCH] ARM: mvebu: Update the SoC ID and revision definitions
Message-ID: <1420729688-31882-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing SoC and revision ID for the Armada 370 and 38x SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/mvebu-soc-id.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.h b/arch/arm/mach-mvebu/mvebu-soc-id.h
index c16bb68ca81f..e124a0b82a3e 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.h
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.h
@@ -20,10 +20,28 @@
 #define MV78XX0_A0_REV	    0x1
 #define MV78XX0_B0_REV	    0x2
 
+/* Amada 370 ID */
+#define ARMADA_370_DEV_ID   0x6710
+
+/* Amada 370 Revision */
+#define ARMADA_370_A1_REV   0x1
+
+/* Armada 375 ID */
+#define ARMADA_375_DEV_ID   0x6720
+
 /* Armada 375 */
 #define ARMADA_375_Z1_REV   0x0
 #define ARMADA_375_A0_REV   0x3
 
+/* Armada 38x ID */
+#define ARMADA_380_DEV_ID   0x6810
+#define ARMADA_385_DEV_ID   0x6820
+#define ARMADA_388_DEV_ID   0x6828
+
+/* Armada 38x Revision */
+#define ARMADA_38x_Z1_REV   0x0
+#define ARMADA_38x_A0_REV   0x4
+
 #ifdef CONFIG_ARCH_MVEBU
 int mvebu_get_soc_id(u32 *dev, u32 *rev);
 #else
-- 
1.9.1
