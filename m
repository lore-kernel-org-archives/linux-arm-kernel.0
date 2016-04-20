From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:16 +0200
Subject: [PATCH 11/14] PCI: hisi: DT spelling s/interrupts-*/interrupt-*/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-12-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index b721beacfe4dae6c..59c2f47aa303ae24 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -34,11 +34,11 @@ Hip05 Example (note that Hip06 is the same except compatible):
 		ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
 		num-lanes = <8>;
 		port-id = <1>;
-		#interrupts-cells = <1>;
-		interrupts-map-mask = <0xf800 0 0 7>;
-		interrupts-map = <0x0 0 0 1 &mbigen_pcie 1 10
-				  0x0 0 0 2 &mbigen_pcie 2 11
-				  0x0 0 0 3 &mbigen_pcie 3 12
-				  0x0 0 0 4 &mbigen_pcie 4 13>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0 0 0 1 &mbigen_pcie 1 10
+				 0x0 0 0 2 &mbigen_pcie 2 11
+				 0x0 0 0 3 &mbigen_pcie 3 12
+				 0x0 0 0 4 &mbigen_pcie 4 13>;
 		status = "ok";
 	};
-- 
1.9.1
