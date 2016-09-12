From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Sep 2016 20:12:36 +0100
Subject: Applied "spi: meson: Add GXBB Compatible string" to the spi tree
In-Reply-To: <1473261223-15412-6-git-send-email-jbrunet@baylibre.com>
Message-ID: <E1bjWei-0003iJ-IE@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: meson: Add GXBB Compatible string

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 164c5cd5ffabfa7a060999f8184927017287c39b Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 8 Sep 2016 09:53:25 +0200
Subject: [PATCH] spi: meson: Add GXBB Compatible string

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
index bb52a86f3365..dc6d0313324a 100644
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -7,7 +7,7 @@ NOR memories, without DMA support and a 64-byte unified transmit /
 receive buffer.
 
 Required properties:
- - compatible: should be "amlogic,meson6-spifc"
+ - compatible: should be "amlogic,meson6-spifc" or "amlogic,meson-gxbb-spifc"
  - reg: physical base address and length of the controller registers
  - clocks: phandle of the input clock for the baud rate generator
  - #address-cells: should be 1
-- 
2.8.1
