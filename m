From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Fri, 26 Aug 2016 00:36:30 -0700
Subject: [PATCH v3 2/3] ARM: dts: rockchip: update compatible strings for
 Rockchip efuse
In-Reply-To: <1472196991-8529-1-git-send-email-finley.xiao@rock-chips.com>
References: <1472196991-8529-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1472196991-8529-3-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 2 +-
 arch/arm/boot/dts/rk3188.dtsi  | 2 +-
 arch/arm/boot/dts/rk3288.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index c0ba86c..5387cc8 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -162,7 +162,7 @@
 	};
 
 	efuse: efuse at 20010000 {
-		compatible = "rockchip,rockchip-efuse";
+		compatible = "rockchip,rk3066a-efuse";
 		reg = <0x20010000 0x4000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 31f81b2..869e189 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -147,7 +147,7 @@
 	};
 
 	efuse: efuse at 20010000 {
-		compatible = "rockchip,rockchip-efuse";
+		compatible = "rockchip,rk3188-efuse";
 		reg = <0x20010000 0x4000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cd33f01..0eadb96 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1073,7 +1073,7 @@
 	};
 
 	efuse: efuse at ffb40000 {
-		compatible = "rockchip,rockchip-efuse";
+		compatible = "rockchip,rk3288-efuse";
 		reg = <0xffb40000 0x20>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
