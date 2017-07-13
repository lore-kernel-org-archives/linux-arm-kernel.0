From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Fri, 14 Jul 2017 00:34:09 +0530
Subject: [PATCH 3/3] Documentation: devicetree: net: optional idm regs for
 bgmac
In-Reply-To: <1499972649-6200-1-git-send-email-abhishek.shah@broadcom.com>
References: <1499972649-6200-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <1499972649-6200-4-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specifying IDM register space in DT is not mendatory for SoCs
where firmware takes care of IDM operations. This patch updates
BGMAC driver's DT binding documentation indicating the same.

Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Oza Oza <oza.oza@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/net/brcm,amac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,amac.txt b/Documentation/devicetree/bindings/net/brcm,amac.txt
index 2fefa1a..ad16c1f 100644
--- a/Documentation/devicetree/bindings/net/brcm,amac.txt
+++ b/Documentation/devicetree/bindings/net/brcm,amac.txt
@@ -11,6 +11,7 @@ Required properties:
  - reg-names:	Names of the registers.
 		"amac_base":	Address and length of the GMAC registers
 		"idm_base":	Address and length of the GMAC IDM registers
+				(required for NSP and Northstar2)
 		"nicpm_base":	Address and length of the NIC Port Manager
 				registers (required for Northstar2)
  - interrupts:	Interrupt number
-- 
2.7.4
