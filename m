From: amstan@chromium.org (Alexandru M Stan)
Date: Fri, 14 Nov 2014 16:00:03 -0800
Subject: [PATCH v2 1/2] clk: rockchip: add bindings for the mmc clock phases
In-Reply-To: <1416009604-31545-1-git-send-email-amstan@chromium.org>
References: <1416009604-31545-1-git-send-email-amstan@chromium.org>
Message-ID: <1416009604-31545-2-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used in a later patch for clock phase tuning.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---
Changes in v2: None

 include/dt-bindings/clock/rk3288-cru.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 100a08c..465d0f6 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -72,6 +72,16 @@
 #define SCLK_HEVC_CABAC		111
 #define SCLK_HEVC_CORE		112
 
+#define SCLK_SDMMC_DRV_PHASE	113
+#define SCLK_SDIO0_DRV_PHASE	114
+#define SCLK_SDIO1_DRV_PHASE	115
+#define SCLK_EMMC_DRV_PHASE	116
+
+#define SCLK_SDMMC_SAMPLE_PHASE	117
+#define SCLK_SDIO0_SAMPLE_PHASE	118
+#define SCLK_SDIO1_SAMPLE_PHASE	119
+#define SCLK_EMMC_SAMPLE_PHASE	120
+
 #define DCLK_VOP0		190
 #define DCLK_VOP1		191
 
-- 
2.1.0.rc2.206.gedb03e5
