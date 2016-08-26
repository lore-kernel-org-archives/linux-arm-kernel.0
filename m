From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Fri, 26 Aug 2016 15:57:43 +0530
Subject: [PATCH 04/10] dt-bindings: spi-nor: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472207269-18499-4-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
index 2c91c03..fc99ef2 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
@@ -13,6 +13,7 @@ Required properties:
                  at25df321a
                  at25df641
                  at26df081a
+		 eon,en25s64
                  mr25h256
                  mx25l4005a
                  mx25l1606e
@@ -29,6 +30,7 @@ Required properties:
                  s25fl008k
                  s25fl064k
                  sst25vf040b
+		 sst,sst25wf040b
                  m25p40
                  m25p80
                  m25p16
-- 
1.9.1
