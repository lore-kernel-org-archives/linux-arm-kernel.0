From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 8 Dec 2016 17:23:02 +0800
Subject: [PATCH 3/5] Documentation: dt: mtd: add chip support for "jedec,
 spi-nor"
In-Reply-To: <1481188984-43683-1-git-send-email-yao.yuan@freescale.com>
References: <1481188984-43683-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1481188984-43683-4-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

"sst25wf040b" and "en25s64" are also chip compatible with SPI NOR flash.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
index 2c91c03..86614ee 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
@@ -13,6 +13,7 @@ Required properties:
                  at25df321a
                  at25df641
                  at26df081a
+                 en25s64
                  mr25h256
                  mx25l4005a
                  mx25l1606e
@@ -29,6 +30,7 @@ Required properties:
                  s25fl008k
                  s25fl064k
                  sst25vf040b
+                 sst25wf040b
                  m25p40
                  m25p80
                  m25p16
-- 
2.1.0.27.g96db324
