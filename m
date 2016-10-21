From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 10:51:15 +0200
Subject: [PATCH v2 4/6] ASoC: davinci-mcbsp: DT fix
 s/interrupts-names/interrupt-names/
In-Reply-To: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
References: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477039877-20227-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Acked-by,
  - Split off from a completely unrelated patch.
---
 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
index 55b53e1fd72c9d6e..e0b6165c9cfcec19 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
@@ -43,7 +43,7 @@ mcbsp0: mcbsp at 1d10000 {
 		<0x00310000 0x1000>;
 	reg-names = "mpu", "dat";
 	interrupts = <97 98>;
-	interrupts-names = "rx", "tx";
+	interrupt-names = "rx", "tx";
 	dmas = <&edma0 3 1
 		&edma0 2 1>;
 	dma-names = "tx", "rx";
-- 
1.9.1
