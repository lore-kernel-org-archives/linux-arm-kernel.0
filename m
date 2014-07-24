From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 01:00:18 +0200
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <1406242820-20140-10-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The specification requires compatible = "adi,axi-spdif-1.00.a" but
driver and example and file name indicate "adi,axi-spdif-tx-1.00.a".
Change the specification to match the implementation.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
index 46f3449..4eb7997 100644
--- a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
+++ b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
@@ -1,7 +1,7 @@
 ADI AXI-SPDIF controller
 
 Required properties:
- - compatible : Must be "adi,axi-spdif-1.00.a"
+ - compatible : Must be "adi,axi-spdif-tx-1.00.a"
  - reg : Must contain SPDIF core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
    The controller expects two clocks, the clock used for the AXI interface and
-- 
1.9.3
