From: jay.xu@rock-chips.com (jianqun.xu)
Date: Wed, 17 Feb 2016 09:53:08 +0800
Subject: [PATCH 2/6] spi: rockchip: add bindings for rk3399 spi
In-Reply-To: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1455673992-16469-3-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xu Jianqun <jay.xu@rock-chips.com>

Add devicetree bindings for Rockchip rk3399 spi which found on
Rockchip rk3399 SoCs.

Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 0c491bd..1b14d69 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -9,6 +9,7 @@ Required Properties:
     "rockchip,rk3066-spi" for rk3066.
     "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
     "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
+    "rockchip,rk3399-spi", "rockchip,rk3066-spi" for rk3399.
 - reg: physical base address of the controller and length of memory mapped
        region.
 - interrupts: The interrupt number to the cpu. The interrupt specifier format
-- 
1.9.1
