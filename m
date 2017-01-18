From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Wed, 18 Jan 2017 13:42:38 +0800
Subject: [PATCH v2 1/3] clk: rockchip: add rk3288 vip_out clock ids
Message-ID: <1484718161-27702-1-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock-ids for the vip block of the rk3288

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 include/dt-bindings/clock/rk3288-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 9a586e2..11183bf 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -88,6 +88,7 @@
 #define SCLK_PVTM_GPU		124
 #define SCLK_CRYPTO		125
 #define SCLK_MIPIDSI_24M	126
+#define SCLK_VIP_OUT	127
 
 #define SCLK_MAC		151
 #define SCLK_MACREF_OUT		152
-- 
2.7.4
