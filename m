From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Mar 2018 01:57:44 +0000 (GMT)
Subject: Applied "ASoC: rockchip: Fix compatible string in example" to the
 asoc tree
In-Reply-To: <20180320160332.13212-4-ezequiel@vanguardiasur.com.ar>
Message-ID: <20180321015744.64AAD44007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Fix compatible string in example

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 279df1917d3e7817983bf5b3476643ec6dfd6f22 Mon Sep 17 00:00:00 2001
From: Ezequiel Garcia <ezequiel@collabora.co.uk>
Date: Tue, 20 Mar 2018 13:03:32 -0300
Subject: [PATCH] ASoC: rockchip: Fix compatible string in example

Use the correct compatible string in the example devicetree
snippet, which was probably overlooked.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
index 2539e1d68107..e5430d1d34e4 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
@@ -22,7 +22,7 @@ Optionnal properties:
 Example:
 
 sound {
-	compatible = "rockchip,rockchip-audio-es8388";
+	compatible = "rockchip,rk3288-hdmi-analog";
 	rockchip,model = "Analog audio output";
 	rockchip,i2s-controller = <&i2s>;
 	rockchip,audio-codec = <&es8388>;
-- 
2.16.2
