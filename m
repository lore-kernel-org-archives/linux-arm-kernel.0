From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 22 Aug 2017 15:57:28 +0800
Subject: [PATCH v5 9/9] dt-bindings: ASoC: rockchip: Update description of
 rockchip, codec
In-Reply-To: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
Message-ID: <20170822075729.8438-10-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update description for newly added optional audio codecs.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v5: None
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
