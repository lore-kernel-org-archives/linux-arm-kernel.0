From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 20 Jan 2015 07:24:55 +0100
Subject: [PATCH 1/2] ARM: BCM5310X: Enable earlyprintk on tested devices
Message-ID: <1421735096-8238-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 2 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       | 2 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 2 +-
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 2 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index b359c1e..ce083a5 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -16,7 +16,7 @@
 	model = "Buffalo WZR-1750DHP (BCM4708)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index 946c728..f57f213 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -16,7 +16,7 @@
 	model = "Luxul XWC-1000 (BCM4708)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index f18c9d9..0a5f561 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -16,7 +16,7 @@
 	model = "Netgear R6250 V1 (BCM4708)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 0ee85ea..4d87219 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -16,7 +16,7 @@
 	model = "Asus RT-N18U (BCM47081)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index db9131e..362f914 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -16,7 +16,7 @@
 	model = "Buffalo WZR-600DHP2 (BCM47081)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
 
 	memory {
-- 
1.8.4.5
