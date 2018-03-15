From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 15 Mar 2018 22:37:08 +0530
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for Bticino
Message-ID: <20180315170710.9551-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added 'bticino' vendor prefix for Bticino International.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae850d6c0ad3..da0ead5b1ea3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -56,6 +56,7 @@ bosch	Bosch Sensortec GmbH
 boundary	Boundary Devices Inc.
 brcm	Broadcom Corporation
 buffalo	Buffalo, Inc.
+bticino Bticino International
 calxeda	Calxeda
 capella	Capella Microsystems, Inc
 cascoda	Cascoda, Ltd.
-- 
2.14.3
