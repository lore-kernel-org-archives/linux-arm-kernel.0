From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 16 Oct 2017 17:34:44 +0200
Subject: [PATCH 1/2] clk: meson: gxbb: Add VPU and VAPB clockids
In-Reply-To: <1508168085-19032-1-git-send-email-narmstrong@baylibre.com>
References: <1508168085-19032-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1508168085-19032-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clkids for the clocks feeding the Video Processing Unit.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.h              |  6 +++++-
 include/dt-bindings/clock/gxbb-clkc.h | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 5b1d4b3..aee6fbb 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -190,8 +190,12 @@
 #define CLKID_SD_EMMC_B_CLK0_DIV  121
 #define CLKID_SD_EMMC_C_CLK0_SEL  123
 #define CLKID_SD_EMMC_C_CLK0_DIV  124
+#define CLKID_VPU_0_DIV		  127
+#define CLKID_VPU_1_DIV		  130
+#define CLKID_VAPB_0_DIV	  134
+#define CLKID_VAPB_1_DIV	  137
 
-#define NR_CLKS			  126
+#define NR_CLKS			  141
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index c04a76d..7c5a6f3 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -113,5 +113,16 @@
 #define CLKID_SD_EMMC_A_CLK0	119
 #define CLKID_SD_EMMC_B_CLK0	122
 #define CLKID_SD_EMMC_C_CLK0	125
+#define CLKID_VPU_0_SEL		126
+#define CLKID_VPU_0		128
+#define CLKID_VPU_1_SEL		129
+#define CLKID_VPU_1		131
+#define CLKID_VPU		132
+#define CLKID_VAPB_0_SEL	133
+#define CLKID_VAPB_0		135
+#define CLKID_VAPB_1_SEL	136
+#define CLKID_VAPB_1		138
+#define CLKID_VAPB_SEL		139
+#define CLKID_VAPB		140
 
 #endif /* __GXBB_CLKC_H */
-- 
2.7.4
