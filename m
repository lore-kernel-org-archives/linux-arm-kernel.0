From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  7 Mar 2017 19:05:15 +0800
Subject: [PATCH v2 1/5] clk: rockchip: rk3368: fix up the timer-ids
In-Reply-To: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
References: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1488884719-10350-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rk3368-cru.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
index 9c5dd9ba2f6c..52f86ddac773 100644
--- a/include/dt-bindings/clock/rk3368-cru.h
+++ b/include/dt-bindings/clock/rk3368-cru.h
@@ -44,12 +44,12 @@
 #define SCLK_I2S_8CH		82
 #define SCLK_SPDIF_8CH		83
 #define SCLK_I2S_2CH		84
-#define SCLK_TIMER0		85
-#define SCLK_TIMER1		86
-#define SCLK_TIMER2		87
-#define SCLK_TIMER3		88
-#define SCLK_TIMER4		89
-#define SCLK_TIMER5		90
+#define SCLK_TIMER00		85
+#define SCLK_TIMER01		86
+#define SCLK_TIMER02		87
+#define SCLK_TIMER03		88
+#define SCLK_TIMER04		89
+#define SCLK_TIMER05		90
 #define SCLK_TIMER6		91
 #define SCLK_OTGPHY0		93
 #define SCLK_OTG_ADP		96
-- 
1.9.1
