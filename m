From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Nov 2018 21:17:48 -0800
Subject: [PATCH v8 3/7] ASoC: dt-bindings: make enable-gpio optional for
 simple amplifier
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Message-ID: <20181121051752.18387-4-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amplifier may have no enable GPIO, so make this property optional

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
index 7182ac4f1e65..b1b097cc9b68 100644
--- a/Documentation/devicetree/bindings/sound/simple-amplifier.txt
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -2,9 +2,9 @@ Simple Amplifier Audio Driver
 
 Required properties:
 - compatible : "dioo,dio2125" or "simple-audio-amplifier"
-- enable-gpios : the gpio connected to the enable pin of the simple amplifier
 
 Optional properties:
+- enable-gpios : the gpio connected to the enable pin of the simple amplifier
 - VCC-supply   : power supply for the device, as covered
                  in Documentation/devicetree/bindings/regulator/regulator.txt
 
-- 
2.19.1
