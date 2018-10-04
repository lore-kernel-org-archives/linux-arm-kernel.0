From: oskari@lemmela.net (Oskari Lemmela)
Date: Thu,  4 Oct 2018 22:34:08 +0300
Subject: [PATCH 2/4] ARM: dtsi: axp81x: add AC power supply subnode
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Message-ID: <20181004193410.7265-3-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AC power supply subnode for AXP81X PMIC.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 043c717dcef1..67c17151b584 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -69,6 +69,11 @@
 		};
 	};
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp813-battery-power-supply";
 		status = "disabled";
-- 
2.17.1
