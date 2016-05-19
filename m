From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 20 May 2016 07:56:20 +0800
Subject: [PATCH v2 1/3] spi/rockchip: add rk3036/rk3228/rk3368 SoCs for spi
 document
Message-ID: <1463702182-5188-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We had supported the rk3036/rk3066/rk3188/rk3228/rk3288/rk3368/rk3399
family SoCs in linux kernel.

Let's add the other SoCs, in order to a better understanding from the
rockchip spi document.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org

---

Changes in v2:
- Drop the fallbacks, As Heiko comments on https://patchwork.kernel.org/patch/9127881/
- update commit

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 1b14d69..d2ca153 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -6,10 +6,13 @@ and display controllers using the SPI communication interface.
 Required Properties:
 
 - compatible: should be one of the following.
-    "rockchip,rk3066-spi" for rk3066.
-    "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
-    "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
-    "rockchip,rk3399-spi", "rockchip,rk3066-spi" for rk3399.
+    "rockchip,rk3036-spi" for rk3036 SoCS.
+    "rockchip,rk3066-spi" for rk3066 SoCs.
+    "rockchip,rk3188-spi" for rk3188 SoCs.
+    "rockchip,rk3228-spi" for rk3228 SoCS.
+    "rockchip,rk3288-spi" for rk3288 SoCs.
+    "rockchip,rk3368-spi" for rk3368 SoCs.
+    "rockchip,rk3399-spi" for rk3399 SoCs.
 - reg: physical base address of the controller and length of memory mapped
        region.
 - interrupts: The interrupt number to the cpu. The interrupt specifier format
-- 
2.7.4
