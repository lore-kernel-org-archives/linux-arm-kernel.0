From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 13:42:58 +0900
Subject: [PATCH 1/4] ARM: shmobile: r8a7779: Add Maximum CPU Frequency to DTS
In-Reply-To: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
References: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400215381-7027-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 1GHz to the r8a7779 DTS to describe the maximum CPU frequency.

Based on work by Magnus dam for the r8a7740 SoC.

Cc: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index bdaaadc..038c16a 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -26,21 +26,25 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clock-frequency = <1000000000>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clock-frequency = <1000000000>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clock-frequency = <1000000000>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
+			clock-frequency = <1000000000>;
 		};
 	};
 
-- 
1.8.5.2
