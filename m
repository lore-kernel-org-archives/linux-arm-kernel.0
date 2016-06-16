From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Thu, 16 Jun 2016 09:53:30 -0400
Subject: [PATCH 2/7] dt-bindings: ata: add support for Broadcom NSP SoC ahci
In-Reply-To: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1466085215-10246-3-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Broadcom NSP SoC ahci

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
index 126ee13..0a5b3b4 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible         : should be one or more of
 			"brcm,bcm7425-ahci"
 			"brcm,bcm7445-ahci"
+			"brcm,bcm-nsp-ahci"
 			"brcm,sata3-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
-- 
2.1.0
