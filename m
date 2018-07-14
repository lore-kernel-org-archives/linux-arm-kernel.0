From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 14 Jul 2018 21:37:21 +0200
Subject: [PATCH v2 1/5] dt-bindings: add vendor prefix for Shenzhen Oranth
 Technology Co., Ltd.
In-Reply-To: <20180714193725.17837-1-martin.blumenstingl@googlemail.com>
References: <20180714193725.17837-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180714193725.17837-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to their website (http://www.oranth.com/about-oranth/)
Shenzhen Oranth Technology Co., Ltd. (or simply "Oranth") "is a
professional Design House & Manufacturer for Android TV Box established
in 2014". One of their brands is Tanix (sometimes also spelled "TANIX").

One of their most popular devices is the "Tanix TX3 Mini" TV box (which
uses the Amlogic S905W chipset).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066191ee..5b9a96d863ee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -271,6 +271,7 @@ opalkelly	Opal Kelly Incorporated
 opencores	OpenCores.org
 openrisc	OpenRISC.io
 option	Option NV
+oranth	Shenzhen Oranth Technology Co., Ltd.
 ORCL	Oracle Corporation
 orisetech	Orise Technology
 ortustech	Ortus Technology Co., Ltd.
-- 
2.18.0
