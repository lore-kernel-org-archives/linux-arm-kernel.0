From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue,  6 Jan 2015 11:37:28 +0100
Subject: [PATCH 3/4] ARM: tegra: Add DTS for the nyan-blaze board
In-Reply-To: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1420540653-14816-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's commercial name is HP Chromebook 14 and is substantially similar to
the Acer Chromebook 13 (nyan-big).

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/tegra124-nyan-blaze.dts | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-blaze.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..7c9d83b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -497,6 +497,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra114-tn7.dtb \
 	tegra124-jetson-tk1.dtb \
 	tegra124-nyan-big.dtb \
+	tegra124-nyan-blaze.dtb \
 	tegra124-venice2.dtb
 dtb-$(CONFIG_ARCH_U300) += ste-u300.dtb
 dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
diff --git a/arch/arm/boot/dts/tegra124-nyan-blaze.dts b/arch/arm/boot/dts/tegra124-nyan-blaze.dts
new file mode 100644
index 0000000..69fe66f
--- /dev/null
+++ b/arch/arm/boot/dts/tegra124-nyan-blaze.dts
@@ -0,0 +1,12 @@
+/dts-v1/;
+
+#include "tegra124-nyan.dtsi"
+
+/ {
+	model = "HP Chromebook 14";
+	compatible = "google,nyan-blaze", "google,nyan", "nvidia,tegra124";
+
+	sound {
+		nvidia,model = "HP Chromebook 14";
+	};
+};
-- 
1.9.3
