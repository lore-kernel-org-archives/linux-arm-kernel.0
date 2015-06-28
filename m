From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 28 Jun 2015 19:46:30 +0200
Subject: [PATCH] ARM: BCM5301X: Enable UART0 on tested devices
In-Reply-To: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
References: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1435513590-32139-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two possible UARTs so we have (both of) them disabled by
default. Override uart0 status on devices that were verified to use it.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 4 ++++
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       | 4 ++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 4 ++++
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 4 ++++
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 4 ++++
 5 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index 24f0ab5..42dcdfb 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -135,3 +135,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index f039393..f18e80e 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -55,3 +55,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 326ce8f..50324b3 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -92,3 +92,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index d6a033b..64a5e8a 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -118,3 +118,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index bb0cb0b..38f0c00 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -122,3 +122,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
-- 
1.8.4.5
