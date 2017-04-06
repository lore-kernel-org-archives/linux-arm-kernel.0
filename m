From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Thu,  6 Apr 2017 19:02:33 +0200
Subject: [PATCH] ARM: dts: aspeed: add a fastread property
Message-ID: <1491498153-26564-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All chips on OpenPOWER platforms support the fastread SPI command.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 2 ++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 2 ++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 8f82e8ab1875..7c90dac99822 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -24,6 +24,7 @@
 	status = "okay";
 	flash at 0 {
 		status = "okay";
+		m25p,fast-read;
 		label = "bmc";
 	};
 };
@@ -32,6 +33,7 @@
 	status = "okay";
 	flash at 0 {
 		status = "okay";
+		m25p,fast-read;
 		label = "pnor";
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index aab1889f702f..112551766275 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -35,6 +35,7 @@
 	status = "okay";
 	flash at 0 {
 		status = "okay";
+		m25p,fast-read;
 		label = "bmc";
 	};
 };
@@ -43,6 +44,7 @@
 	status = "okay";
 	flash at 0 {
 		status = "okay";
+		m25p,fast-read;
 		label = "pnor";
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index e3c6358bc7d9..b82f67eb3dae 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -35,6 +35,7 @@
 	status = "okay";
 	flash at 0 {
 		status = "okay";
+		m25p,fast-read;
 		label = "bmc";
 	};
 };
@@ -43,6 +44,7 @@
 	status = "okay";
 	flash at 0 {
 		status = "okay";
+		m25p,fast-read;
 		label = "pnor";
 	};
 };
-- 
2.7.4
