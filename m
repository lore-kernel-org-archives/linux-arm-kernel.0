From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Tue, 10 Jan 2017 19:59:19 +0800
Subject: [PATCH 3/4] clk: rockchip: add rk3288 cif_out clock ids
In-Reply-To: <1484049560-14820-1-git-send-email-jacob-chen@iotwrt.com>
References: <1484049560-14820-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1484049560-14820-3-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock-ids for the cif block of the rk3288


Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 include/dt-bindings/clock/rk3288-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 08de7de..128b191 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -88,6 +88,7 @@
 #define SCLK_PVTM_GPU		124
 #define SCLK_CRYPTO		125
 #define SCLK_MIPIDSI_24M	126
+#define SCLK_CIF_OUT		127
 
 #define SCLK_MAC		151
 #define SCLK_MACREF_OUT		152
-- 
2.7.4
