From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Aug 2014 10:42:59 +0200
Subject: [RFC PATCH 1/6] of: Change vendor prefix for Intersil Corporation to
 isil
In-Reply-To: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1408524184-31928-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. At this point, changing the vendor
symbol to the most often used variant, which is equal to the
NASDAQ symbol, isil, should not hurt.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 +-
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 6af570e..6504297 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -56,7 +56,7 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-isl,isl12057		Intersil ISL12057 I2C RTC Chip
+isil,isl12057		Intersil ISL12057 I2C RTC Chip
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I?C-Compatible Serial Interface
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..938e0ce 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -68,7 +68,7 @@ img	Imagination Technologies Ltd.
 intel	Intel Corporation
 intercontrol	Inter Control Group
 isee	ISEE 2007 S.L.
-isl	Intersil
+isil	Intersil Corporation
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
 lacie	LaCie
-- 
2.1.0.rc1
