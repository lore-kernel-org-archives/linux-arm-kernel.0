From: jay.xu@rock-chips.com (jianqun.xu)
Date: Wed, 17 Feb 2016 09:53:09 +0800
Subject: [PATCH 3/6] ASoC: rockchip: add bindings for rk3399 i2s
In-Reply-To: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1455673992-16469-4-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xu Jianqun <jay.xu@rock-chips.com>

Add devicetree bindings for i2s controller found on rk3399
processors from rockchip.

Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index b7f3a93..6e86d8a 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -9,6 +9,7 @@ Required properties:
    - "rockchip,rk3066-i2s": for rk3066
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+   - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
-- 
1.9.1
