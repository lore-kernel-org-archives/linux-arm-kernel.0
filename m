From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  7 Mar 2017 19:05:16 +0800
Subject: [PATCH v2 2/5] clk: rockchip: rk3368: remove the unused id
In-Reply-To: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
References: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1488884719-10350-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove SCLK_TIMER6 id

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rk3368-cru.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
index 52f86ddac773..2bf23eda8938 100644
--- a/include/dt-bindings/clock/rk3368-cru.h
+++ b/include/dt-bindings/clock/rk3368-cru.h
@@ -50,7 +50,6 @@
 #define SCLK_TIMER03		88
 #define SCLK_TIMER04		89
 #define SCLK_TIMER05		90
-#define SCLK_TIMER6		91
 #define SCLK_OTGPHY0		93
 #define SCLK_OTG_ADP		96
 #define SCLK_HSICPHY480M	97
-- 
1.9.1
