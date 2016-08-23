From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Aug 2016 17:04:48 +0200
Subject: [PATCH] dt-bindings: touchscreen: silead_gsl1680: Document
 touchscreen-fw-name
Message-ID: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has supported touchscreen-fw-name to specify the firmware to
load since day 0, but this was omitted from the binding, document this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
index ad7f41a..c9c1ddd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
@@ -17,6 +17,7 @@ Required properties:
 - touchscreen-size-y	  : See touchscreen.txt
 
 Optional properties:
+- touchscreen-fw-name	  : Filename (string) for device specific firmware
 - touchscreen-inverted-x  : See touchscreen.txt
 - touchscreen-inverted-y  : See touchscreen.txt
 - touchscreen-swapped-x-y : See touchscreen.txt
-- 
2.7.4
