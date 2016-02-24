From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 24 Feb 2016 18:14:25 +0800
Subject: [PATCH v1 3/4] clk: rockchip: add the new clock ids for RK3228 HDMI
In-Reply-To: <1456308303-29706-1-git-send-email-ykk@rock-chips.com>
References: <1456308303-29706-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1456308865-30876-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 include/dt-bindings/clock/rk3228-cru.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
index 5656bf6..fda9308 100644
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ b/include/dt-bindings/clock/rk3228-cru.h
@@ -50,9 +50,11 @@
 #define SCLK_SDIO_SAMPLE	119
 #define SCLK_EMMC_SAMPLE	121
 #define SCLK_VOP		122
+#define SCLK_HDMI_HDCP		123
 
 /* dclk gates */
 #define DCLK_VOP		190
+#define DCLK_HDMI_PHY		191
 
 /* aclk gates */
 #define ACLK_DMAC		194
@@ -76,6 +78,8 @@
 #define PCLK_PWM		350
 #define PCLK_TIMER		353
 #define PCLK_PERI		363
+#define PCLK_HDMI_CTRL		364
+#define PCLK_HDMI_PHY		365
 
 /* hclk gates */
 #define HCLK_VOP		452
-- 
1.9.1
