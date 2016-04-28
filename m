From: j-keerthy@ti.com (Keerthy)
Date: Thu, 28 Apr 2016 15:35:47 +0530
Subject: [PATCH RESEND 2/4] ARM: dts: am57xx: Introduce industrial grade
 thermal thresholds
In-Reply-To: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1461837949-11116-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The silicon version ES2.0 onwards are industrial grade samples
and have higher thermal thresholds than commecial grade samples.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am57xx-industrial-grade.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/arm/boot/dts/am57xx-industrial-grade.dtsi

diff --git a/arch/arm/boot/dts/am57xx-industrial-grade.dtsi b/arch/arm/boot/dts/am57xx-industrial-grade.dtsi
new file mode 100644
index 0000000..70c8c4b
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-industrial-grade.dtsi
@@ -0,0 +1,23 @@
+&cpu_alert0 {
+	temperature = <90000>; /* milliCelsius */
+};
+
+&cpu_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&gpu_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&core_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&dspeve_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&iva_crit {
+	temperature = <105000>; /* milliCelsius */
+};
-- 
1.9.1
