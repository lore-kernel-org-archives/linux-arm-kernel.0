From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 17 Aug 2017 16:57:37 +0800
Subject: [PATCH] pinctrl: mediatek: update PCIe pinmux data
Message-ID: <7e51745301c377eb8527bdf6171eaf26fc53b0b4.1502959698.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update pinmux data so that PCIe function can work normally.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
index f906420..bdbb491 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
@@ -223,11 +223,11 @@
 		MTK_EINT_FUNCTION(0, 0),
 		MTK_FUNCTION(0, "GPIO22"),
 		MTK_FUNCTION(1, "UCTS0"),
+		MTK_FUNCTION(2, "PCIE0_PERST_N"),
 		MTK_FUNCTION(3, "KCOL3"),
 		MTK_FUNCTION(4, "CONN_DSP_JDO"),
 		MTK_FUNCTION(5, "EXT_FRAME_SYNC"),
-		MTK_FUNCTION(7, "DBG_MON_A[30]"),
-		MTK_FUNCTION(10, "PCIE0_PERST_N")
+		MTK_FUNCTION(7, "DBG_MON_A[30]")
 	),
 	MTK_PIN(
 		PINCTRL_PIN(23, "EINT1"),
@@ -235,11 +235,11 @@
 		MTK_EINT_FUNCTION(0, 1),
 		MTK_FUNCTION(0, "GPIO23"),
 		MTK_FUNCTION(1, "URTS0"),
+		MTK_FUNCTION(2, "PCIE1_PERST_N"),
 		MTK_FUNCTION(3, "KCOL2"),
 		MTK_FUNCTION(4, "CONN_MCU_TDO"),
 		MTK_FUNCTION(5, "EXT_FRAME_SYNC"),
-		MTK_FUNCTION(7, "DBG_MON_A[29]"),
-		MTK_FUNCTION(10, "PCIE1_PERST_N")
+		MTK_FUNCTION(7, "DBG_MON_A[29]")
 	),
 	MTK_PIN(
 		PINCTRL_PIN(24, "EINT2"),
@@ -247,10 +247,10 @@
 		MTK_EINT_FUNCTION(0, 2),
 		MTK_FUNCTION(0, "GPIO24"),
 		MTK_FUNCTION(1, "UCTS1"),
+		MTK_FUNCTION(2, "PCIE2_PERST_N"),
 		MTK_FUNCTION(3, "KCOL1"),
 		MTK_FUNCTION(4, "CONN_MCU_DBGACK_N"),
-		MTK_FUNCTION(7, "DBG_MON_A[28]"),
-		MTK_FUNCTION(10, "PCIE2_PERST_N")
+		MTK_FUNCTION(7, "DBG_MON_A[28]")
 	),
 	MTK_PIN(
 		PINCTRL_PIN(25, "EINT3"),
@@ -308,8 +308,8 @@
 		MTK_FUNCTION(3, "KROW0"),
 		MTK_FUNCTION(4, "CONN_MCU_TMS"),
 		MTK_FUNCTION(5, "CONN_MCU_AICE_JMSC"),
-		MTK_FUNCTION(7, "DBG_MON_A[23]"),
-		MTK_FUNCTION(14, "PCIE2_PERST_N")
+		MTK_FUNCTION(6, "PCIE2_PERST_N"),
+		MTK_FUNCTION(7, "DBG_MON_A[23]")
 	),
 	MTK_PIN(
 		PINCTRL_PIN(30, "I2S5_LRCK"),
@@ -1787,10 +1787,10 @@
 		MTK_FUNCTION(0, "GPIO208"),
 		MTK_FUNCTION(1, "AUD_EXT_CK1"),
 		MTK_FUNCTION(2, "PWM0"),
+		MTK_FUNCTION(3, "PCIE0_PERST_N"),
 		MTK_FUNCTION(4, "ANT_SEL5"),
 		MTK_FUNCTION(5, "DISP_PWM"),
-		MTK_FUNCTION(7, "DBG_MON_A[31]"),
-		MTK_FUNCTION(11, "PCIE0_PERST_N")
+		MTK_FUNCTION(7, "DBG_MON_A[31]")
 	),
 	MTK_PIN(
 		PINCTRL_PIN(209, "AUD_EXT_CK2"),
@@ -1798,10 +1798,10 @@
 		MTK_EINT_FUNCTION(0, 121),
 		MTK_FUNCTION(0, "GPIO209"),
 		MTK_FUNCTION(1, "AUD_EXT_CK2"),
+		MTK_FUNCTION(3, "PCIE1_PERST_N"),
 		MTK_FUNCTION(2, "MSDC1_WP"),
 		MTK_FUNCTION(5, "PWM1"),
-		MTK_FUNCTION(7, "DBG_MON_A[32]"),
-		MTK_FUNCTION(11, "PCIE1_PERST_N")
+		MTK_FUNCTION(7, "DBG_MON_A[32]")
 	),
 	MTK_PIN(
 		PINCTRL_PIN(210, "AUD_CLOCK"),
-- 
1.9.1
