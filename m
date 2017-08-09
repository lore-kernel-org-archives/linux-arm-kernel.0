From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:46 +0800
Subject: [PATCH 05/10] arm64: dts: zx296718: add voltage data into OPP table
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-6-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

We will enable PWM device to control voltage through pwm-regulator
support.  So let's add voltage data into OPP table.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 507bc39be96b..74c37e443627 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -127,26 +127,31 @@
 
 		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <866000>;
 			clock-latency-ns = <500000>;
 		};
 
 		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <866000>;
 			clock-latency-ns = <500000>;
 		};
 
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <888000>;
 			clock-latency-ns = <500000>;
 		};
 
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <898000>;
 			clock-latency-ns = <500000>;
 		};
 
 		opp-1188000000 {
 			opp-hz = /bits/ 64 <1188000000>;
+			opp-microvolt = <1015000>;
 			clock-latency-ns = <500000>;
 		};
 	};
-- 
1.9.1
