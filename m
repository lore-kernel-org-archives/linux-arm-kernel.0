From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 30 Aug 2018 21:01:08 +0200
Subject: [PATCH v4 01/13] dt-bindings: ata: ahci-platform: fix indentation of
 target-supply
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Message-ID: <20180830190120.722-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the indentation of target-supply's ':'.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 5d5bd456d9d9..b88820b4c01e 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -47,7 +47,7 @@ Sub-nodes required properties:
 - reg		    : the port number
 And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
-- target-supply    : regulator for SATA target power
+- target-supply     : regulator for SATA target power
 
 Examples:
         sata at ffe08000 {
-- 
2.16.4
