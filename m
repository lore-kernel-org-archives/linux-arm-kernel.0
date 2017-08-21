From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 21 Aug 2017 16:16:04 +0800
Subject: [PATCH v2 1/4] clk: rockchip: add rv1108 ACLK_GAMC and PCLK_GMAC ID
In-Reply-To: <1503303367-17915-1-git-send-email-zhangqing@rock-chips.com>
References: <1503303367-17915-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1503303367-17915-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports gmac aclk and pclk for dts reference.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rv1108-cru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/rv1108-cru.h b/include/dt-bindings/clock/rv1108-cru.h
index f269d833e41a..2239ae2a19b9 100644
--- a/include/dt-bindings/clock/rv1108-cru.h
+++ b/include/dt-bindings/clock/rv1108-cru.h
@@ -110,6 +110,7 @@
 #define ACLK_CIF2			207
 #define ACLK_CIF3			208
 #define ACLK_PERI			209
+#define ACLK_GMAC			210
 
 /* pclk gates */
 #define PCLK_GPIO1			256
@@ -141,6 +142,7 @@
 #define PCLK_EFUSE0			282
 #define PCLK_EFUSE1			283
 #define PCLK_WDT			284
+#define PCLK_GMAC			285
 
 /* hclk gates */
 #define HCLK_I2S0_8CH			320
-- 
1.9.1
