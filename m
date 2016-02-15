From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 15 Feb 2016 15:33:26 +0800
Subject: [RESEND PATCH 1/8] clk: rockchip: add id of the tsadc clock found on
 rk3228 SoCs
In-Reply-To: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1455521613-27340-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 'SCLK_TSADC' and 'PCLK_TSADC' id found on rk3228 SoCs.
That will be needed by TSADC controller.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 include/dt-bindings/clock/rk3228-cru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
index a78dd89..cd2e06b 100644
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ b/include/dt-bindings/clock/rk3228-cru.h
@@ -29,6 +29,7 @@
 #define SCLK_SDMMC		68
 #define SCLK_SDIO		69
 #define SCLK_EMMC		71
+#define SCLK_TSADC		72
 #define SCLK_UART0		77
 #define SCLK_UART1		78
 #define SCLK_UART2		79
@@ -68,6 +69,7 @@
 #define PCLK_UART0		341
 #define PCLK_UART1		342
 #define PCLK_UART2		343
+#define PCLK_TSADC		344
 #define PCLK_PWM		350
 #define PCLK_TIMER		353
 #define PCLK_PERI		363
-- 
1.9.1
