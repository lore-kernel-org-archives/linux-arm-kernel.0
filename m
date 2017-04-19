From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Wed, 19 Apr 2017 15:30:22 +0800
Subject: [PATCH 1/2] clk: rockchip: add SCLK_TESTCLKOUT1 id
In-Reply-To: <20170419073023.1921-1-eddie.cai.linux@gmail.com>
References: <20170419073023.1921-1-eddie.cai.linux@gmail.com>
Message-ID: <20170419073023.1921-2-eddie.cai.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we use SCLK_TESTCLKOUT1 for camera, so add this id.

Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
---
 include/dt-bindings/clock/rk3399-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 220a60f..c505a98 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -132,6 +132,7 @@
 #define SCLK_RMII_SRC			166
 #define SCLK_PCIEPHY_REF100M		167
 #define SCLK_DDRC			168
+#define SCLK_TESTCLKOUT1		169
 
 #define DCLK_VOP0			180
 #define DCLK_VOP1			181
-- 
2.10.2
