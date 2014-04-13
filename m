From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:40:01 +0200
Subject: [PATCH 24/29] ARM: orion5x: keep TODO list in edmini_v2 DT
In-Reply-To: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397400006-4315-25-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to the complete removal of non-DT support for
edmini_v2, this commit copies the TODO list of things to support from
the old-style board file into the Device Tree of edmini_v2.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 44cc36a..ffa0fc5 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -6,6 +6,13 @@
  * warranty of any kind, whether express or implied.
  */
 
+/*
+ * TODO: add Orion USB device port init when kernel.org support is added.
+ * TODO: add flash write support: see below.
+ * TODO: add power-off support.
+ * TODO: add I2C EEPROM support.
+ */
+
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
-- 
1.8.3.2
