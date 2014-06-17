From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 17 Jun 2014 09:38:43 +0200
Subject: [PATCH v4 7/7] mfd: AXP20x: add "x-powers,
 axp221" compatible string to DT bindings doc
In-Reply-To: <1402990723-28138-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1402990723-28138-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1402990723-28138-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "x-powers,axp221" compatible string to the AXP20x DT bindings
documentation.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index cc9e01b..f22a169 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -5,7 +5,7 @@ axp202 (X-Powers)
 axp209 (X-Powers)
 
 Required properties:
-- compatible: "x-powers,axp202" or "x-powers,axp209"
+- compatible: "x-powers,axp202", "x-powers,axp209" or "x-powers,axp221"
 - reg: The I2C slave address for the AXP chip
 - interrupt-parent: The parent interrupt controller
 - interrupts: Interrupt specifiers for interrupt sources
-- 
1.8.3.2
