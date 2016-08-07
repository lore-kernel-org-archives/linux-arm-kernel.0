From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  7 Aug 2016 20:57:48 +0200
Subject: [PATCH 1/2] dt: bindings: Add vendor prefix for Espressif System
Message-ID: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Espressif is a manufacturer of various wifi and bt chips, add a vendor
prefix for use with bindings for these chips.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d2bce22..d83a2da 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -88,6 +88,7 @@ energymicro	Silicon Laboratories (formerly Energy Micro AS)
 epcos	EPCOS AG
 epfl	Ecole Polytechnique F?d?rale de Lausanne
 epson	Seiko Epson Corp.
+esp	Espressif System
 est	ESTeem Wireless Modems
 ettus	NI Ettus Research
 eukrea  Eukr?a Electromatique
-- 
2.7.4
