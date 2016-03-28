From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 28 Mar 2016 10:18:29 +0530
Subject: [PATCH v2 4/5] dt-bindings: ata: add compatible string for iProc AHCI
 controller
In-Reply-To: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1459140510-5317-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom iProc SoCs have AHCI compliant SATA controller. This
patch adds common compatible string for AHCI SATA controller on
iProc SoCs.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 30df832..3990348 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -10,6 +10,7 @@ PHYs.
 Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
+  - "brcm,iproc-ahci"
   - "hisilicon,hisi-ahci"
   - "cavium,octeon-7130-ahci"
   - "ibm,476gtr-ahci"
-- 
1.9.1
