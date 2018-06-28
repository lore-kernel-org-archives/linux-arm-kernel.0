From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 28 Jun 2018 14:09:13 -0700
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Add thermal-zones node
Message-ID: <20180628210915.160893-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node is empty for now. It is needed to allow other DT snippets
to add thermal zone entries.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Sorry if you received this twice, lists were missing in cc in the first attempt ...

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 00722b533a92..968390fb0933 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -1087,4 +1088,7 @@
 			};
 		};
 	};
+
+	thermal_zones: thermal-zones {
+	};
 };
-- 
2.18.0.rc2.346.g013aa6912e-goog
