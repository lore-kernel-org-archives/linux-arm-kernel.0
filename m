From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 20 Jun 2018 10:59:59 +0900
Subject: [PATCH] ASoC: add hp-det-gpio and mic-det-gpio to audio graph card
 binding
Message-ID: <20180620015959.10312-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add headphone and microphone detection GPIO support to audio graph
card same as supported in simple card.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
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
2.17.1
