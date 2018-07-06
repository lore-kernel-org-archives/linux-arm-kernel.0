From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  6 Jul 2018 10:32:49 +0200
Subject: [PATCH v5 4/4] dt-bindings: net: btusb: DT fix
 s/interrupt-name/interrupt-names/
In-Reply-To: <20180706083249.25399-1-geert+renesas@glider.be>
References: <20180706083249.25399-1-geert+renesas@glider.be>
Message-ID: <20180706083249.25399-5-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: fd913ef7ce619467 ("Bluetooth: btusb: Add out-of-band wakeup support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v4:
  - Add Acked-by,

v3:
  - New.
---
 Documentation/devicetree/bindings/net/btusb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index 9c5e663fa1afccaf..828a04695e1be517 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -36,7 +36,7 @@ Following example uses irq pin number 3 of gpio0 for out of band wake-on-bt:
 	compatible = "usb1286,204e";
 	reg = <1>;
 	interrupt-parent = <&gpio0>;
-	interrupt-name = "wakeup";
+	interrupt-names = "wakeup";
 	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
     };
 };
-- 
2.17.1
