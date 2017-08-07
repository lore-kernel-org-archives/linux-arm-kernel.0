From: broonie@kernel.org (Mark Brown)
Date: Mon, 07 Aug 2017 12:51:57 +0100
Subject: Applied "ASoC: rockchip: add bindings for i2s" to the asoc tree
In-Reply-To: <1501465671-22863-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <E1degZh-0006lR-R0@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: add bindings for i2s

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3508cade13ba43ebafbee9064fa6114e857afd20 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Mon, 31 Jul 2017 09:47:51 +0800
Subject: [PATCH] ASoC: rockchip: add bindings for i2s

This patch add bindings for rk3036/rk3228/rk3328/rk3366 i2s.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 206aba1b34bb..b208a752576c 100644
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
2.13.3
