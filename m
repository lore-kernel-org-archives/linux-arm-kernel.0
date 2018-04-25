From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 25 Apr 2018 12:19:58 +0800
Subject: [PATCH 5/6] ASoC: mediatek: add MT7622 AFE compatible in documentation
In-Reply-To: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
References: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
Message-ID: <43bf5fcef0edefef2524122e64400785243f4fdf.1524628914.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for MT7622 AFE which shares the same binding with MT2701.

Cc: devicetree at vger.kernel.org
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index e2f7f49..560762e 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -1,7 +1,9 @@
 Mediatek AFE PCM controller for mt2701
 
 Required properties:
-- compatible = "mediatek,mt2701-audio";
+- compatible: should be one of the followings.
+	      - "mediatek,mt2701-audio"
+	      - "mediatek,mt7622-audio"
 - interrupts: should contain AFE and ASYS interrupts
 - interrupt-names: should be "afe" and "asys"
 - power-domains: should define the power domain
-- 
1.9.1
