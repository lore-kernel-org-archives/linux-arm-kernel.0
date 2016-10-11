From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 11 Oct 2016 08:33:58 +0800
Subject: [PATCH 4/5] MAINTAINERS: Add myself as maintainer of ili2139
 touchscreen driver
In-Reply-To: <20161011003359.26079-1-icenowy@aosc.xyz>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
Message-ID: <20161011003359.26079-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a009e00..8f8341b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6112,6 +6112,12 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
 S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
+ILI2139 TOUCHSCREEN DRIVER
+M:	Icenowy Zheng <icenowy@aosc.xyz>
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt
+F:	drivers/input/touchscreen/ili2139.c
+
 INA209 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon at vger.kernel.org
-- 
2.10.1
