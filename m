From: hl@rock-chips.com (Lin Huang)
Date: Wed, 10 Aug 2016 11:26:38 +0800
Subject: [PATCH v5 2/8] clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
In-Reply-To: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
References: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
Message-ID: <1470799604-12877-3-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v5:
-None
Changes in v4:
-None

Changes in v3:
-None

Changes in v2:
-None 

Changes in v1:
-None

 include/dt-bindings/clock/rk3399-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 50a44cf..ce5f3e9 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -131,6 +131,7 @@
 #define SCLK_DPHY_RX0_CFG		165
 #define SCLK_RMII_SRC			166
 #define SCLK_PCIEPHY_REF100M		167
+#define SCLK_DDRC			168
 
 #define DCLK_VOP0			180
 #define DCLK_VOP1			181
-- 
1.9.1
