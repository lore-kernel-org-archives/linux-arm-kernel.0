From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Thu, 20 Feb 2014 06:02:36 +1000
Subject: [PATCH v7 3/4] DT: i2c: Trivial: Add sii,s35390a
In-Reply-To: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
References: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <1392840157-31072-4-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Add the Seiko Instruments Inc S35390a to the list of trivial i2c
devices.

Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 1 file changed, 1 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 1a1ac2e..5f37191 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -58,6 +58,7 @@ plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
 ramtron,24c64		i2c serial eeprom  (24cxx)
 ricoh,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
+sii,s35390a		2-wire CMOS real-time clock
 st-micro,24c256		i2c serial eeprom  (24cxx)
 stm,m41t00		Serial Access TIMEKEEPER
 stm,m41t62		Serial real-time clock (RTC) with alarm
-- 
1.8.3.2
