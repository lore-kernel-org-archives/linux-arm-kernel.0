From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Nov 2017 20:22:16 +0000
Subject: Applied "spi: meson-axg: update compatible string for the Meson-AXG"
 to the spi tree
In-Reply-To: <20171128132926.19051-2-yixun.lan@amlogic.com>
Message-ID: <E1eJmOW-0008Dj-RE@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: meson-axg: update compatible string for the Meson-AXG

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From a78841479696efa557a2251c86462c936a208f90 Mon Sep 17 00:00:00 2001
From: Sunny Luo <sunny.luo@amlogic.com>
Date: Tue, 28 Nov 2017 21:29:24 +0800
Subject: [PATCH] spi: meson-axg: update compatible string for the Meson-AXG

Update the compatbile string to support Meson-AXG SoCs.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-meson.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
index 825c39cae74a..b7f5e86fed22 100644
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -27,7 +27,9 @@ The Meson SPICC is generic SPI controller for general purpose Full-Duplex
 communications with dedicated 16 words RX/TX PIO FIFOs.
 
 Required properties:
- - compatible: should be "amlogic,meson-gx-spicc" on Amlogic GX SoCs.
+ - compatible: should be:
+	"amlogic,meson-gx-spicc" on Amlogic GX and compatible SoCs.
+	"amlogic,meson-axg-spicc" on Amlogic AXG and compatible SoCs
  - reg: physical base address and length of the controller registers
  - interrupts: The interrupt specifier
  - clock-names: Must contain "core"
-- 
2.15.0
