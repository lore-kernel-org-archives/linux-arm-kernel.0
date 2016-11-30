From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 30 Nov 2016 15:00:17 +0100
Subject: [PATCH v6 4/4] dt-bindings: i2c: pxa: Update the documentation for
 the Armada 3700
In-Reply-To: <20161130140017.26307-1-romain.perier@free-electrons.com>
References: <20161130140017.26307-1-romain.perier@free-electrons.com>
Message-ID: <20161130140017.26307-5-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit documents the compatible string to have the compatibility for
the I2C unit found in the Armada 3700.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v5:
 - Added the tag 'Acked-by', by Rob Herring

Changes in v2:
 - Fixed wrong compatible string, it should be "marvell,armada-3700-i2c"
   and not "marvell,armada-3700".

 Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
index 12b78ac..d30f0b1 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
@@ -7,6 +7,7 @@ Required properties :
    compatible processor, e.g. pxa168, pxa910, mmp2, mmp3.
    For the pxa2xx/pxa3xx, an additional node "mrvl,pxa-i2c" is required
    as shown in the example below.
+   For the Armada 3700, the compatible should be "marvell,armada-3700-i2c".
 
 Recommended properties :
 
-- 
2.9.3
