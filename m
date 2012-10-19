From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 19 Oct 2012 12:28:56 +0530
Subject: [PATCH] Documentation: dt: i2c: Update trivial-devices list
Message-ID: <1350629936-13397-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update i2c trivial-devices list by adding the description for
ti,tmp275 temperature sensor and taos,tsl2550 ambient light
sensor.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 2f5322b..446859f 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -55,5 +55,7 @@ st-micro,24c256		i2c serial eeprom  (24cxx)
 stm,m41t00		Serial Access TIMEKEEPER
 stm,m41t62		Serial real-time clock (RTC) with alarm
 stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
+taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
 ti,tsc2003		I2C Touch-Screen Controller
 ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
+ti,tmp275		Digital Temperature Sensor
-- 
1.7.9.5
