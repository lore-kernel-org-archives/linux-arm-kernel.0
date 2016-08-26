From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Fri, 26 Aug 2016 15:57:46 +0530
Subject: [PATCH 07/10] dt-bindings: thermal: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472207269-18499-7-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
index 66223d5..8e2b211 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -1,7 +1,7 @@
 * Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
 
 Required properties:
-- compatible : Must include "fsl,qoriq-tmu". The version of the device is
+- compatible :"fsl,qoriq-tmu", "fsl,ls1012a-tmu". The version of the device is
 	determined by the TMU IP Block Revision Register (IPBRR0) at
 	offset 0x0BF8.
 	Table of correspondences between IPBRR0 values and example  chips:
-- 
1.9.1
