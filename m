From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 14 Jul 2015 19:23:23 +0530
Subject: [PATCH v3 2/2] ARM: dts: vf-colibri: Add property for minimum sample
 time
In-Reply-To: <cover.1436880513.git.maitysanchayan@gmail.com>
References: <cover.1436880513.git.maitysanchayan@gmail.com>
Message-ID: <20e2cfad3fbb1a45332e9936ea493ddc8bfaf51d.1436880513.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree property which allows to specify the minimum sample
time which can be used to calculate the actual ADC cycles required
depending on the hardware.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index ab10d2e..59f5deb 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -16,10 +16,12 @@
 };
 
 &adc0 {
+	min-sample-time = <1000>;
 	status = "okay";
 };
 
 &adc1 {
+	min-sample-time = <1000>;
 	status = "okay";
 };
 
-- 
2.4.5
