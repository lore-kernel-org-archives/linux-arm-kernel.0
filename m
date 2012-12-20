From: pengw@nvidia.com (Bryan Wu)
Date: Thu, 20 Dec 2012 11:41:29 -0800
Subject: [PATCH 2/2] ARM: DT: tegra: Unify the description of Tegra20 boards
In-Reply-To: <1356032489-27619-1-git-send-email-pengw@nvidia.com>
References: <1356032489-27619-1-git-send-email-pengw@nvidia.com>
Message-ID: <1356032489-27619-2-git-send-email-pengw@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use engineering name 'Tegra20' instead of 'Tegra2'

Signed-off-by: Bryan Wu <pengw@nvidia.com>
---
 arch/arm/boot/dts/tegra20-harmony.dts  |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts  |    2 +-
 arch/arm/boot/dts/tegra20-whistler.dts |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 43eb72a..b506de9 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -3,7 +3,7 @@
 /include/ "tegra20.dtsi"
 
 / {
-	model = "NVIDIA Tegra2 Harmony evaluation board";
+	model = "NVIDIA Tegra20 Harmony evaluation board";
 	compatible = "nvidia,harmony", "nvidia,tegra20";
 
 	memory {
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index adc4754..0392dea 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -3,7 +3,7 @@
 /include/ "tegra20.dtsi"
 
 / {
-	model = "NVIDIA Tegra2 Ventana evaluation board";
+	model = "NVIDIA Tegra20 Ventana evaluation board";
 	compatible = "nvidia,ventana", "nvidia,tegra20";
 
 	memory {
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 20d576e..5836ad6 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -3,7 +3,7 @@
 /include/ "tegra20.dtsi"
 
 / {
-	model = "NVIDIA Tegra2 Whistler evaluation board";
+	model = "NVIDIA Tegra20 Whistler evaluation board";
 	compatible = "nvidia,whistler", "nvidia,tegra20";
 
 	memory {
-- 
1.7.10.4
