From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 17:58:12 +0100
Subject: [PATCH] ARM: at91/dt/trivial: correct file headers for SAMA5D3 SoC
 peripherals
Message-ID: <1425488292-21303-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

File name had at91 prefix, which is not the case anymore for SAMA5D3.
AT91SAM9x5 was mentioned instead of SAMA5D3 SoC.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3_can.dtsi  | 2 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi | 2 +-
 arch/arm/boot/dts/sama5d3_gmac.dtsi | 2 +-
 arch/arm/boot/dts/sama5d3_lcd.dtsi  | 2 +-
 arch/arm/boot/dts/sama5d3_mci2.dtsi | 2 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi | 2 +-
 arch/arm/boot/dts/sama5d3_uart.dtsi | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3_can.dtsi b/arch/arm/boot/dts/sama5d3_can.dtsi
index eaf41451ad0c..c5a3772741bf 100644
--- a/arch/arm/boot/dts/sama5d3_can.dtsi
+++ b/arch/arm/boot/dts/sama5d3_can.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sama5d3_can.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
+ * sama5d3_can.dtsi - Device Tree Include file for SAMA5D3 SoC with
  * CAN support
  *
  * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
diff --git a/arch/arm/boot/dts/sama5d3_emac.dtsi b/arch/arm/boot/dts/sama5d3_emac.dtsi
index fe2af9276312..ca4094d8d0fc 100644
--- a/arch/arm/boot/dts/sama5d3_emac.dtsi
+++ b/arch/arm/boot/dts/sama5d3_emac.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sama5d3_emac.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
+ * sama5d3_emac.dtsi - Device Tree Include file for SAMA5D3 SoC with
  * Ethernet.
  *
  * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
diff --git a/arch/arm/boot/dts/sama5d3_gmac.dtsi b/arch/arm/boot/dts/sama5d3_gmac.dtsi
index de5ed59fb446..23f225fbb756 100644
--- a/arch/arm/boot/dts/sama5d3_gmac.dtsi
+++ b/arch/arm/boot/dts/sama5d3_gmac.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sama5d3_gmac.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
+ * sama5d3_gmac.dtsi - Device Tree Include file for SAMA5D3 SoC with
  * Gigabit Ethernet.
  *
  * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
index 85d302701565..8aeff6c122aa 100644
--- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
+++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sama5d3_lcd.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
+ * sama5d3_lcd.dtsi - Device Tree Include file for SAMA5D3 SoC with
  * LCD support
  *
  * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
diff --git a/arch/arm/boot/dts/sama5d3_mci2.dtsi b/arch/arm/boot/dts/sama5d3_mci2.dtsi
index 1b02208ea6ff..026b252f09b3 100644
--- a/arch/arm/boot/dts/sama5d3_mci2.dtsi
+++ b/arch/arm/boot/dts/sama5d3_mci2.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sama5d3_mci2.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
+ * sama5d3_mci2.dtsi - Device Tree Include file for SAMA5D3 SoC with
  * 3 MMC ports
  *
  * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
diff --git a/arch/arm/boot/dts/sama5d3_tcb1.dtsi b/arch/arm/boot/dts/sama5d3_tcb1.dtsi
index 02848453ca0c..f7fa58fe09f1 100644
--- a/arch/arm/boot/dts/sama5d3_tcb1.dtsi
+++ b/arch/arm/boot/dts/sama5d3_tcb1.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sama5d3_tcb1.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
+ * sama5d3_tcb1.dtsi - Device Tree Include file for SAMA5D3 SoC with
  * 2 TC blocks.
  *
  * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
index 7a8d4c6115f7..2511d748867b 100644
--- a/arch/arm/boot/dts/sama5d3_uart.dtsi
+++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sama5d3_uart.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
+ * sama5d3_uart.dtsi - Device Tree Include file for SAMA5D3 SoC with
  * UART support
  *
  * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
-- 
2.1.3
