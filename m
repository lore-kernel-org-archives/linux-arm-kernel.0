From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sat, 12 Sep 2015 00:36:44 +0200
Subject: [PATCH 1/2] pinctrl: rockchip: Define GPIO banks 7 and 8
Message-ID: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip RK3288 has 9 GPIO banks (0 to 8) add definitions for the last
two.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

 include/dt-bindings/pinctrl/rockchip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index 743e66a..efc57cf 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -24,6 +24,8 @@
 #define RK_GPIO3	3
 #define RK_GPIO4	4
 #define RK_GPIO6	6
+#define RK_GPIO7	7
+#define RK_GPIO8	8
 
 #define RK_FUNC_GPIO	0
 #define RK_FUNC_1	1
-- 
2.5.1
