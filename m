From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Mon, 31 Jul 2017 09:47:51 +0800
Subject: [PATCH] ASoC: rockchip: add bindings for i2s
Message-ID: <1501465671-22863-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add bindings for rk3036/rk3228/rk3328/rk3366 i2s.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 206aba1..b208a75 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -7,8 +7,12 @@ Required properties:
 
 - compatible: should be one of the following:
    - "rockchip,rk3066-i2s": for rk3066
+   - "rockchip,rk3036-i2s", "rockchip,rk3066-i2s": for rk3036
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
+   - "rockchip,rk3228-i2s", "rockchip,rk3066-i2s": for rk3228
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+   - "rockchip,rk3328-i2s", "rockchip,rk3066-i2s": for rk3328
+   - "rockchip,rk3366-i2s", "rockchip,rk3066-i2s": for rk3366
    - "rockchip,rk3368-i2s", "rockchip,rk3066-i2s": for rk3368
    - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
 - reg: physical base address of the controller and length of memory mapped
-- 
2.7.4
