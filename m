From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Oct 2016 14:18:59 +0200
Subject: [PATCH v3 2/3] Documentation: dt-bindings: rename meson-usb2-phy to
 meson8b-usb2-phy
In-Reply-To: <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161001121900.1168-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The corresponding driver only supports the USB PHY on Meson8b and GXBB
SoCs. Newer SoC versions are using a different USB PHY implementation,
which will mean that a new driver is required. Thus make sure that our
naming is specific enough so it does not conflict with upcoming drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/phy/{meson-usb2-phy.txt => meson8b-usb2-phy.txt}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/phy/{meson-usb2-phy.txt => meson8b-usb2-phy.txt} (95%)

diff --git a/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
similarity index 95%
rename from Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
rename to Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
index bc616c1..5fa73b9 100644
--- a/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
@@ -1,4 +1,4 @@
-* Amlogic USB2 PHY
+* Amlogic Meson8b and GXBB USB2 PHY
 
 Required properties:
 - compatible:	Depending on the platform this should be one of:
-- 
2.10.0
