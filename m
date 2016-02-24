From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 24 Feb 2016 18:08:20 +0800
Subject: [PATCH v1 1/4] clk: rockchip: add the new clock ids for RK3228 VOP
In-Reply-To: <1456308303-29706-1-git-send-email-ykk@rock-chips.com>
References: <1456308303-29706-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1456308500-30075-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are four clocks that vop module would need to operate:
    DCLK_VOP,  HCLK_VOP,  SCLK_VOP,  ACLK_VOP,

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 include/dt-bindings/clock/rk3228-cru.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
index a78dd89..5656bf6 100644
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ b/include/dt-bindings/clock/rk3228-cru.h
@@ -49,10 +49,15 @@
 #define SCLK_SDMMC_SAMPLE	118
 #define SCLK_SDIO_SAMPLE	119
 #define SCLK_EMMC_SAMPLE	121
+#define SCLK_VOP		122
+
+/* dclk gates */
+#define DCLK_VOP		190
 
 /* aclk gates */
 #define ACLK_DMAC		194
 #define ACLK_PERI		210
+#define ACLK_VOP		211
 
 /* pclk gates */
 #define PCLK_GPIO0		320
@@ -73,6 +78,7 @@
 #define PCLK_PERI		363
 
 /* hclk gates */
+#define HCLK_VOP		452
 #define HCLK_NANDC		453
 #define HCLK_SDMMC		456
 #define HCLK_SDIO		457
-- 
1.9.1
