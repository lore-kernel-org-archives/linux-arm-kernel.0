From: jon.mason@broadcom.com (Jon Mason)
Date: Mon,  6 Mar 2017 11:29:04 -0500
Subject: [PATCH] arm64: dts: NS2: convert "ok" to "okay"
Message-ID: <1488817744-7844-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per e-mail from Sergei Shtylyov, the DT spec dictates it should be
"okay" (although "ok" is also recognized).  Thus, changing all "ok" to
"okay" in NS2 device tree files

Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 38 ++++++++++++++++----------------
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts | 20 ++++++++---------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 5ae0816..ec19fbf 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -57,55 +57,55 @@
 };
 
 &enet {
-	status = "ok";
+	status = "okay";
 };
 
 &pci_phy0 {
-	status = "ok";
+	status = "okay";
 };
 
 &pci_phy1 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie0 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie4 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie8 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c0 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c1 {
-	status = "ok";
+	status = "okay";
 };
 
 &uart0 {
-	status = "ok";
+	status = "okay";
 };
 
 &uart1 {
-	status = "ok";
+	status = "okay";
 };
 
 &uart2 {
-	status = "ok";
+	status = "okay";
 };
 
 &uart3 {
-	status = "ok";
+	status = "okay";
 };
 
 &ssp0 {
-	status = "ok";
+	status = "okay";
 
 	slic at 0 {
 		compatible = "silabs,si3226x";
@@ -126,7 +126,7 @@
 };
 
 &ssp1 {
-	status = "ok";
+	status = "okay";
 
 	at25 at 0 {
 		compatible = "atmel,at25";
@@ -150,23 +150,23 @@
 };
 
 &sata_phy0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata_phy1 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata {
-	status = "ok";
+	status = "okay";
 };
 
 &sdio0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sdio1 {
-	status = "ok";
+	status = "okay";
 };
 
 &nand {
diff --git a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
index 99a2723..ab4ae1a 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
@@ -54,15 +54,15 @@
 };
 
 &enet {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c0 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c1 {
-	status = "ok";
+	status = "okay";
 };
 
 &mdio_mux_iproc {
@@ -122,27 +122,27 @@
 };
 
 &pci_phy0 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie0 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie8 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata_phy0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata_phy1 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata {
-	status = "ok";
+	status = "okay";
 };
 
 &qspi {
@@ -187,5 +187,5 @@
 };
 
 &uart3 {
-	status = "ok";
+	status = "okay";
 };
-- 
2.7.4
