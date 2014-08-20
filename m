From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Aug 2014 10:43:00 +0200
Subject: [RFC PATCH 2/6] Documentation: Add isl1208 and isl12022 to
 trivial-devices list
In-Reply-To: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1408524184-31928-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Intersil ISL1208 and ISL12022 I2C RTCs to the
trivial-devices list.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 6504297..ec4c6b2 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -56,6 +56,8 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+isil,isl1208		Intersil ISL1208 I2C RTC Chip
+isil,isl12022		Intersil ISL12022 I2C RTC Chip
 isil,isl12057		Intersil ISL12057 I2C RTC Chip
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
-- 
2.1.0.rc1
