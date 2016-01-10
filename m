From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sun, 10 Jan 2016 15:22:37 +0800
Subject: [PATCH] dt-bindings: Fix the external clock name for the RK3036 EMAC
Message-ID: <1452410557-29208-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the RK3036 doesn't support EMAC, and only support the RMII mode
in the EMAC IP, we refer to the TRM CRU and update the new external
clock name for EMAC.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 .../bindings/clock/rockchip,rk3036-cru.txt         |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
index ace0599..20df350 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
@@ -30,7 +30,7 @@ that they are defined using standard clock bindings with following
 clock-output-names:
  - "xin24m" - crystal input - required,
  - "ext_i2s" - external I2S clock - optional,
- - "ext_gmac" - external GMAC clock - optional
+ - "rmii_clkin" - external EMAC clock - optional
 
 Example: Clock controller node:
 
-- 
1.7.9.5
