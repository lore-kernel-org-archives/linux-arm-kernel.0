From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 16 Feb 2016 12:03:39 +0530
Subject: [PATCH 4/5] dt-bindings: ata: add compatible string for iProc AHCI
 controller
In-Reply-To: <1455604420-11300-1-git-send-email-anup.patel@broadcom.com>
References: <1455604420-11300-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1455604420-11300-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom iProc SoCs have AHCI compliant SATA controller. This
patch adds common compatible string for AHCI SATA controller on
iProc SoCs.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c2340ee..caee721 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -10,6 +10,7 @@ PHYs.
 Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
+  - "brcm,iproc-ahci"
   - "hisilicon,hisi-ahci"
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
-- 
1.9.1
