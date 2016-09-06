From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue,  6 Sep 2016 23:38:48 +0200
Subject: [PATCH v5 6/6] net: stmmac: update the module description of the
 dwmac-meson driver
In-Reply-To: <20160906213848.17785-1-martin.blumenstingl@googlemail.com>
References: <20160904182320.671-1-martin.blumenstingl@googlemail.com>
 <20160906213848.17785-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160906213848.17785-7-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-meson glue driver supports Meson6 and Meson8 SoCs. Newer SoCs
are supported by the dwmac-meson8b driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index c1bac19..309d995 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -1,5 +1,5 @@
 /*
- * Amlogic Meson DWMAC glue layer
+ * Amlogic Meson6 and Meson8 DWMAC glue layer
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
  *
@@ -96,5 +96,5 @@ static struct platform_driver meson6_dwmac_driver = {
 module_platform_driver(meson6_dwmac_driver);
 
 MODULE_AUTHOR("Beniamino Galvani <b.galvani@gmail.com>");
-MODULE_DESCRIPTION("Amlogic Meson DWMAC glue layer");
+MODULE_DESCRIPTION("Amlogic Meson6 and Meson8 DWMAC glue layer");
 MODULE_LICENSE("GPL v2");
-- 
2.9.3
