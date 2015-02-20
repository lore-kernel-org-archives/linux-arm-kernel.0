From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 18:04:24 +0100
Subject: [PATCHv2 05/15] ARM: mvebu: add stdout-path to all armada-*.dts
In-Reply-To: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the stdout-path property in /chosen for all Armada
boards that were not yet carrying this property.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              | 1 +
 arch/arm/boot/dts/armada-370-mirabox.dts         | 1 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 1 +
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 1 +
 arch/arm/boot/dts/armada-370-rd.dts              | 1 +
 arch/arm/boot/dts/armada-375-db.dts              | 1 +
 arch/arm/boot/dts/armada-388-db.dts              | 1 +
 arch/arm/boot/dts/armada-388-rd.dts              | 1 +
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 1 +
 arch/arm/boot/dts/armada-xp-db.dts               | 1 +
 arch/arm/boot/dts/armada-xp-gp.dts               | 1 +
 arch/arm/boot/dts/armada-xp-matrix.dts           | 1 +
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 1 +
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 1 +
 14 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index e993c46..286bedd 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -56,6 +56,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index b10ceb4..ec77b86 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -52,6 +52,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 7c5c4ff..8c786cf 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -54,6 +54,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 1de53b5..1d64532 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -54,6 +54,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 6ae36a3..f40d35b 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -65,6 +65,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 0440891..033665c 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -56,6 +56,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index af6c74e..c56ccd74 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -55,6 +55,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index d99baac..e17edbb 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -56,6 +56,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index c1fbab2..a7fd474 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -60,6 +60,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 48bdafe..a12e159 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -65,6 +65,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 206aebb..8a2e49e 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -66,6 +66,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 56f958e..3e81f22 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -53,6 +53,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index a7ceafd..508a395 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -54,6 +54,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 0c76d9f..7b2ea2060 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -55,6 +55,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
-- 
2.1.0
