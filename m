From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 18 Jun 2015 15:46:17 +0200
Subject: [PATCH v7 01/14] crypto: mv_cesa: document the clocks property
In-Reply-To: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1434635190-27733-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dove platforms, the crypto engine requires a clock. Document this
clocks property in the mv_cesa bindings doc.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/crypto/mv_cesa.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/mv_cesa.txt b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
index 47229b1..eaa2873 100644
--- a/Documentation/devicetree/bindings/crypto/mv_cesa.txt
+++ b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
@@ -7,6 +7,8 @@ Required properties:
         length
 - reg-names : "regs" , "sram";
 - interrupts : interrupt number
+- clocks: reference to the crypto engines clocks. This property is only
+	  required for Dove platforms
 
 Examples:
 
-- 
1.9.1
