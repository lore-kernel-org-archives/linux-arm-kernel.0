From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  5 Jul 2015 11:00:19 +0200
Subject: [PATCH 6/7] clk: rockchip: add missing include guards
In-Reply-To: <1436086820-3757-1-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
Message-ID: <1436086820-3757-7-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Review for the rk3368 turned up that the clock header was missing include
guards. This is also true for the already existing clock binding headers,
so add them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rk3066a-cru.h       | 5 +++++
 include/dt-bindings/clock/rk3188-cru-common.h | 5 +++++
 include/dt-bindings/clock/rk3188-cru.h        | 5 +++++
 include/dt-bindings/clock/rk3288-cru.h        | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/include/dt-bindings/clock/rk3066a-cru.h b/include/dt-bindings/clock/rk3066a-cru.h
index bc1ed1d..d3a9824 100644
--- a/include/dt-bindings/clock/rk3066a-cru.h
+++ b/include/dt-bindings/clock/rk3066a-cru.h
@@ -13,6 +13,9 @@
  * GNU General Public License for more details.
  */
 
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3066A_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RK3066A_H
+
 #include <dt-bindings/clock/rk3188-cru-common.h>
 
 /* soft-reset indices */
@@ -33,3 +36,5 @@
 #define SRST_HDMI		96
 #define SRST_HDMI_APB		97
 #define SRST_CIF1		111
+
+#endif
diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
index 6a37050..8df77a7 100644
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -13,6 +13,9 @@
  * GNU General Public License for more details.
  */
 
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3188_COMMON_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RK3188_COMMON_H
+
 /* core clocks from */
 #define PLL_APLL		1
 #define PLL_DPLL		2
@@ -248,3 +251,5 @@
 #define SRST_PTM1_ATB		141
 #define SRST_CTM		142
 #define SRST_TS			143
+
+#endif
diff --git a/include/dt-bindings/clock/rk3188-cru.h b/include/dt-bindings/clock/rk3188-cru.h
index 9fac8ed..9f2e631 100644
--- a/include/dt-bindings/clock/rk3188-cru.h
+++ b/include/dt-bindings/clock/rk3188-cru.h
@@ -13,6 +13,9 @@
  * GNU General Public License for more details.
  */
 
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3188_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RK3188_H
+
 #include <dt-bindings/clock/rk3188-cru-common.h>
 
 /* soft-reset indices */
@@ -49,3 +52,5 @@
 #define SRST_GPU_BRIDGE		121
 #define SRST_CTI3		123
 #define SRST_CTI3_APB		124
+
+#endif
diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index dea4197..c719aac 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -13,6 +13,9 @@
  * GNU General Public License for more details.
  */
 
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3288_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RK3288_H
+
 /* core clocks */
 #define PLL_APLL		1
 #define PLL_DPLL		2
@@ -376,3 +379,5 @@
 #define SRST_TSP_CLKIN0		189
 #define SRST_TSP_CLKIN1		190
 #define SRST_TSP_27M		191
+
+#endif
-- 
2.1.4
