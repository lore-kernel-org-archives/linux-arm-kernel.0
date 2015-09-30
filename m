From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Wed, 30 Sep 2015 15:46:42 +0200
Subject: [RESEND][PATCH v3 5/9] of: Add Boundary Devices Inc. vendor prefix
In-Reply-To: <1443620806-14792-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1443620806-14792-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1443620806-14792-6-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the vendor prefix for Boundary Devices Inc. which is a
supplier of ARM-based single board computers and System-on-Modules for
the general embedded market.

Website: http://boundarydevices.com/

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 82d2ac9..eca468d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -34,6 +34,7 @@ avago	Avago Technologies
 avic	Shanghai AVIC Optoelectronics Co., Ltd.
 axis	Axis Communications AB
 bosch	Bosch Sensortec GmbH
+boundary	Boundary Devices Inc.
 brcm	Broadcom Corporation
 buffalo	Buffalo, Inc.
 calxeda	Calxeda
-- 
2.5.3
