From: j-keerthy@ti.com (Keerthy)
Date: Thu, 28 Apr 2016 15:35:46 +0530
Subject: [PATCH RESEND 1/4] ARM: dts: am57xx: Introduce commercial grade
 thermal thresholds
In-Reply-To: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1461837949-11116-2-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The silicon versions which are non ES2.0 are commercial grade silicon
and have lower thermal thresholds.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am57xx-commercial-grade.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/arm/boot/dts/am57xx-commercial-grade.dtsi

diff --git a/arch/arm/boot/dts/am57xx-commercial-grade.dtsi b/arch/arm/boot/dts/am57xx-commercial-grade.dtsi
new file mode 100644
index 0000000..c183654
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-commercial-grade.dtsi
@@ -0,0 +1,23 @@
+&cpu_alert0 {
+	temperature = <80000>; /* milliCelsius */
+};
+
+&cpu_crit {
+	temperature = <90000>; /* milliCelsius */
+};
+
+&gpu_crit {
+	temperature = <90000>; /* milliCelsius */
+};
+
+&core_crit {
+	temperature = <90000>; /* milliCelsius */
+};
+
+&dspeve_crit {
+	temperature = <90000>; /* milliCelsius */
+};
+
+&iva_crit {
+	temperature = <90000>; /* milliCelsius */
+};
-- 
1.9.1
