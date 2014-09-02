From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue,  2 Sep 2014 18:40:42 +0300
Subject: [PATCH v2 2/3] ARM: dts: qcom: Enable serial port on IFC6540 boards
In-Reply-To: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
References: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1409672443-4289-3-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the serial port on the IFC6540 boards.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
index 4603e91..e41cb8a 100644
--- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
@@ -3,4 +3,10 @@
 / {
 	model = "Qualcomm APQ8084/IFC6540";
 	compatible = "qcom,apq8084-ifc6540", "qcom,apq8084";
+
+	soc {
+		serial at f995e000 {
+			status = "okay";
+		};
+	};
 };
-- 
1.7.9.5
