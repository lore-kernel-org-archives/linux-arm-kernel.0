From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Jun 2018 15:50:25 +0100
Subject: Applied "ASoC: add hp-det-gpio and mic-det-gpio to audio graph card
 binding" to the asoc tree
In-Reply-To: <20180620015959.10312-1-suzuki.katsuhiro@socionext.com>
Message-ID: <E1fWNOL-0002cU-Oj@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: add hp-det-gpio and mic-det-gpio to audio graph card binding

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

>From a12f671b4241f53e7cd9dec8770d51549682453b Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Wed, 20 Jun 2018 10:59:59 +0900
Subject: [PATCH] ASoC: add hp-det-gpio and mic-det-gpio to audio graph card
 binding

Add headphone and microphone detection GPIO support to audio graph
card same as supported in simple card.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/audio-graph-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index d04ea3b1a1dd..7e63e53a901c 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -18,6 +18,8 @@ Below are same as Simple-Card.
 - bitclock-inversion
 - frame-inversion
 - mclk-fs
+- hp-det-gpio
+- mic-det-gpio
 - dai-tdm-slot-num
 - dai-tdm-slot-width
 - clocks / system-clock-frequency
-- 
2.18.0.rc2
