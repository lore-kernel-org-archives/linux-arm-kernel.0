From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  8 Sep 2015 16:34:42 +0200
Subject: [PATCH v2 5/9] of: Add Boundary Devices Inc. vendor prefix
In-Reply-To: <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441722886-22798-6-git-send-email-gary.bisson@boundarydevices.com>
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
index ac5f0c3..4c67e2a 100644
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
2.5.1
