From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Mar 2013 15:23:34 +0100
Subject: [PATCH 2/4] ARM: at91/trivial: typos in compatible property
In-Reply-To: <cover.1363960549.git.nicolas.ferre@atmel.com>
References: <cover.1363960549.git.nicolas.ferre@atmel.com>
Message-ID: <df0e644fa686115c042dce7152c17fdcbd71ed0f.1363960549.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- unneeded whitespace
- missing double quote

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> # 3.8+
---
 arch/arm/boot/dts/at91sam9g15.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g35.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9x25.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9x35.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g15.dtsi b/arch/arm/boot/dts/at91sam9g15.dtsi
index fbe7a70..28467fd 100644
--- a/arch/arm/boot/dts/at91sam9g15.dtsi
+++ b/arch/arm/boot/dts/at91sam9g15.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	model = "Atmel AT91SAM9G15 SoC";
-	compatible = "atmel, at91sam9g15, atmel,at91sam9x5";
+	compatible = "atmel,at91sam9g15", "atmel,at91sam9x5";
 
 	ahb {
 		apb {
diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index 05a718f..5fd32df 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	model = "Atmel AT91SAM9G25 SoC";
-	compatible = "atmel, at91sam9g25, atmel,at91sam9x5";
+	compatible = "atmel,at91sam9g25", "atmel,at91sam9x5";
 
 	ahb {
 		apb {
diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/at91sam9g35.dtsi
index f9d14a7..d6fa8af 100644
--- a/arch/arm/boot/dts/at91sam9g35.dtsi
+++ b/arch/arm/boot/dts/at91sam9g35.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	model = "Atmel AT91SAM9G35 SoC";
-	compatible = "atmel, at91sam9g35, atmel,at91sam9x5";
+	compatible = "atmel,at91sam9g35", "atmel,at91sam9x5";
 
 	ahb {
 		apb {
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
index 54eb33b..9ac2bc2 100644
--- a/arch/arm/boot/dts/at91sam9x25.dtsi
+++ b/arch/arm/boot/dts/at91sam9x25.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	model = "Atmel AT91SAM9X25 SoC";
-	compatible = "atmel, at91sam9x25, atmel,at91sam9x5";
+	compatible = "atmel,at91sam9x25", "atmel,at91sam9x5";
 
 	ahb {
 		apb {
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91sam9x35.dtsi
index fb102d6..ba67d83 100644
--- a/arch/arm/boot/dts/at91sam9x35.dtsi
+++ b/arch/arm/boot/dts/at91sam9x35.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	model = "Atmel AT91SAM9X35 SoC";
-	compatible = "atmel, at91sam9x35, atmel,at91sam9x5";
+	compatible = "atmel,at91sam9x35", "atmel,at91sam9x5";
 
 	ahb {
 		apb {
-- 
1.8.0
