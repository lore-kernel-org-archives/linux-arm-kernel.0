From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 25 Jul 2014 12:40:02 -0600
Subject: [PATCH 1/2] ARM: tegra: paz00: Fix some indentation inconsistencies
In-Reply-To: <1406313603-11893-1-git-send-email-swarren@wwwdotorg.org>
References: <1406313603-11893-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1406313603-11893-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Indentation of the clock property used a hodgepodge of tabs and spaces.
Make them more consistent (tabs for indentation followed by spaces for
alignment).

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 9a39a8001f78..d4438e30de45 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -296,7 +296,7 @@
 		request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		slave-addr = <138>;
 		clocks = <&tegra_car TEGRA20_CLK_I2C3>,
-		       	 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
+		         <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 67>;
 		reset-names = "i2c";
@@ -589,8 +589,8 @@
 			GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
-		       	 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA20_CLK_CDEV1>;
+		         <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
+		         <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
-- 
1.9.1
