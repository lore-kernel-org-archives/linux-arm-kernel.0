From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 18 Aug 2017 11:49:24 +0800
Subject: [PATCH v1 1/2] clk: rockchip: add rk3228 sclk_sdio_src ID
In-Reply-To: <1503028165-27072-1-git-send-email-zhangqing@rock-chips.com>
References: <1503028165-27072-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1503028165-27072-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports sdio src clock for dts reference.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rk3228-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
index 56f841c22801..55655ab0a4c4 100644
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ b/include/dt-bindings/clock/rk3228-cru.h
@@ -49,6 +49,7 @@
 #define SCLK_EMMC_DRV		117
 #define SCLK_SDMMC_SAMPLE	118
 #define SCLK_SDIO_SAMPLE	119
+#define SCLK_SDIO_SRC		120
 #define SCLK_EMMC_SAMPLE	121
 #define SCLK_VOP		122
 #define SCLK_HDMI_HDCP		123
-- 
1.9.1
