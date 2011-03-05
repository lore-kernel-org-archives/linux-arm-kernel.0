From: shweta.gulati@ti.com (Shweta Gulati)
Date: Sat,  5 Mar 2011 15:21:53 +0530
Subject: [PATCH V2 2/3] OMAP4: Update Voltage Rail Values for MPU/IVA
Message-ID: <1299318713-21389-1-git-send-email-shweta.gulati@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update MPU/IVA voltage Rail values obtained from
OMAP4430 Data Manual Operating Condition Addendum_v0.3.

Tested on OMAP4430 SDP Board.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-arm-kernel at lists.infradead.org 
---
 arch/arm/mach-omap2/opp4xxx_data.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 93b9744..36a4517 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -31,10 +31,10 @@
  * voltage dependent data for each VDD.
  */
 
-#define OMAP4430_VDD_MPU_OPP50_UV		930000
-#define OMAP4430_VDD_MPU_OPP100_UV		1100000
-#define OMAP4430_VDD_MPU_OPPTURBO_UV		1260000
-#define OMAP4430_VDD_MPU_OPPNITRO_UV		1350000
+#define OMAP4430_VDD_MPU_OPP50_UV		1025000
+#define OMAP4430_VDD_MPU_OPP100_UV		1200000
+#define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
+#define OMAP4430_VDD_MPU_OPPNITRO_UV		1375000
 
 struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP50_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP50, 0xf4, 0x0c),
@@ -44,9 +44,9 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
-#define OMAP4430_VDD_IVA_OPP50_UV		930000
-#define OMAP4430_VDD_IVA_OPP100_UV		1100000
-#define OMAP4430_VDD_IVA_OPPTURBO_UV		1260000
+#define OMAP4430_VDD_IVA_OPP50_UV		1013000
+#define OMAP4430_VDD_IVA_OPP100_UV		1188000
+#define OMAP4430_VDD_IVA_OPPTURBO_UV		1300000
 
 struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP50_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP50, 0xf4, 0x0c),
-- 
1.7.0.4
