From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 10:51:16 +0200
Subject: [PATCH v2 5/6] dt: booting-without-of: DT fix
 s/#interrupt-cell/#interrupt-cells/
In-Reply-To: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
References: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477039877-20227-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Acked-by.
---
 Documentation/devicetree/booting-without-of.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index 3f1437fbca6b49f3..5bcea91c0cc65af2 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -1302,7 +1302,7 @@ number and level/sense information. All interrupt children in an
 OpenPIC interrupt domain use 2 cells per interrupt in their interrupts
 property.
 
-The PCI bus binding specifies a #interrupt-cell value of 1 to encode
+The PCI bus binding specifies a #interrupt-cells value of 1 to encode
 which interrupt pin (INTA,INTB,INTC,INTD) is used.
 
 2) interrupt-parent property
-- 
1.9.1
