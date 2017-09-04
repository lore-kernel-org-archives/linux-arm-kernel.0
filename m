From: romain.perier@collabora.com (Romain Perier)
Date: Mon,  4 Sep 2017 10:51:16 +0200
Subject: [PATCH v2 1/4] clk: rockchip: add clock id for PCLK_EFUSE256 of
 RK3368 SoCs
In-Reply-To: <20170904085119.25981-1-romain.perier@collabora.com>
References: <20170904085119.25981-1-romain.perier@collabora.com>
Message-ID: <20170904085119.25981-2-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 include/dt-bindings/clock/rk3368-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
index aeb83e581a11..a0063ed7284a 100644
--- a/include/dt-bindings/clock/rk3368-cru.h
+++ b/include/dt-bindings/clock/rk3368-cru.h
@@ -156,6 +156,7 @@
 #define PCLK_ISP		366
 #define PCLK_VIP		367
 #define PCLK_WDT		368
+#define PCLK_EFUSE256		369
 
 /* hclk gates */
 #define HCLK_SFC		448
-- 
2.11.0
