From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Sep 2014 15:11:30 +0200
Subject: [PATCH 1/2] ARM: meson: documentation: add timer documentation
In-Reply-To: <1410786691-30302-1-git-send-email-carlo@caione.org>
References: <1410786691-30302-1-git-send-email-carlo@caione.org>
Message-ID: <1410786691-30302-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 .../devicetree/bindings/timer/amlogic,meson6-timer.txt   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
new file mode 100644
index 0000000..d79be27
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
@@ -0,0 +1,16 @@
+Amlogic Meson6 SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-timer"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+
+Example:
+
+timer at c1109940 {
+	compatible = "amlogic,meson6-timer";
+	reg = <0xc1109940 0x14>;
+	interrupts = <0 10 1>;
+};
+
-- 
1.9.1
