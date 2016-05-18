From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 18 May 2016 18:36:30 -0500
Subject: [PATCH 5/8] ARM: dts: am437x-gp-evm: Hook dcdc2 as the cpu0-supply
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
Message-ID: <da3d9998f2e71a213e50364fd20b3c94d3403ccd.1463606963.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook dcdc2 as the cpu0-supply.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 5bcd3aa025bc..84832bf26b39 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -975,3 +975,7 @@
 	clock-names = "ext-clk", "int-clk";
 	status = "okay";
 };
+
+&cpu {
+	cpu0-supply = <&dcdc2>;
+};
-- 
2.7.3
