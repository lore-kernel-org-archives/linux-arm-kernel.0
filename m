From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  4 Apr 2013 17:26:59 -0600
Subject: [PATCH] clk: tegra: Fix cdev1 and cdev2 IDs
In-Reply-To: <1365118019-5748-1-git-send-email-swarren@wwwdotorg.org>
References: <1365118019-5748-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365118019-5748-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prashant Gaikwad <pgaikwad@nvidia.com>

Correct IDs for cdev1 and cdev2 are 94 and 93 respectively.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
[swarren: split into separate driver and device-tree patches]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I split this patch in two when applying it. Reposting just so everyone
can see exactly what I applied. This is the patch from Tegra's
for-3.10/dt branch.

 arch/arm/boot/dts/tegra20-colibri-512.dtsi |    2 +-
 arch/arm/boot/dts/tegra20-harmony.dts      |    2 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts  |    2 +-
 arch/arm/boot/dts/tegra20-paz00.dts        |    2 +-
 arch/arm/boot/dts/tegra20-plutux.dts       |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     |    2 +-
 arch/arm/boot/dts/tegra20-tec.dts          |    2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts      |    2 +-
 arch/arm/boot/dts/tegra20-whistler.dts     |    2 +-
 arch/arm/boot/dts/tegra20.dtsi             |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index a094787..a573b94 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -483,7 +483,7 @@
 
 		nvidia,ac97-controller = <&ac97>;
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index a44b54e..e7d5de4 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -687,7 +687,7 @@
 		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
 		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index 740ba7c..ace2343 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -59,7 +59,7 @@
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 8c0e9a2..e3e0c99 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -522,7 +522,7 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts
index 7085ae5..1a17cc3 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts
@@ -53,7 +53,7 @@
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index c45b698..cee4c34 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -830,7 +830,7 @@
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 185 0>; /* gpio PX1 */
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 9be175d..742f0b3 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -53,7 +53,7 @@
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index f2fbc38..9cc78a1 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -397,7 +397,7 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&codec>;
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 395df48..dd38f1f 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -640,7 +640,7 @@
 		nvidia,int-mic-en-gpios = <&gpio 184 0>; /* gpio PX0 */
 		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 2ed6bb8..d2567f8 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -584,7 +584,7 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&codec>;
 
-		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 1911432..3e676a2 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -478,7 +478,7 @@
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5004400 0x3c00>;
 		phy_type = "ulpi";
-		clocks = <&tegra_car 94>, <&tegra_car 127>;
+		clocks = <&tegra_car 93>, <&tegra_car 127>;
 		clock-names = "phy", "pll_u";
 	};
 
-- 
1.7.10.4
