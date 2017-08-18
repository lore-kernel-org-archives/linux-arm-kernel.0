From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 18 Aug 2017 11:11:47 +0800
Subject: [PATCH v4 9/9] dt-bindings: ASoC: rockchip: Update description of
 rockchip, codec
In-Reply-To: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
Message-ID: <20170818031147.16810-10-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update description for newly added optional audio codecs.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index f19b6c830a34..f54b4e91e97c 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible: "rockchip,rk3399-gru-sound"
 - rockchip,cpu: The phandle of the Rockchip I2S controller that's
   connected to the codecs
-- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
+- rockchip,codec: The phandle of the audio codecs
 
 Example:
 
-- 
2.11.0
