From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Jan 2017 13:37:09 +0000
Subject: Applied "ASoC: sunxi: Add bindings for sun8i to SPDIF" to the asoc
 tree
In-Reply-To: <20170112173343.9953-1-codekipper@gmail.com>
Message-ID: <E1cUZNN-0000hQ-U0@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: Add bindings for sun8i to SPDIF

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

>From cb5c978f9a56c459d5f13901efcfe44b97c4182d Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Thu, 19 Jan 2017 20:52:57 +0100
Subject: [PATCH] ASoC: sunxi: Add bindings for sun8i to SPDIF

The H3 SoC uses the same SPDIF block as found in earlier SoCs, but the
transmit fifo is at a different address.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
index 0230c4d20506..fe0a65e6d629 100644
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -10,6 +10,7 @@ Required properties:
   - compatible		: should be one of the following:
     - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
     - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
+    - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.11.0
