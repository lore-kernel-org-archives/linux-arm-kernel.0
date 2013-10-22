From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:56:16 +0200
Subject: [PATCH 1/2] Documentation: DTS: bq27xxx are trivial i2c devices
Message-ID: <1382446577-28270-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add all chips supported by the bq27xxx driver to the list
of trivial i2c devices.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index ad6a738..d3a29ce 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -58,6 +58,9 @@ stm,m41t00		Serial Access TIMEKEEPER
 stm,m41t62		Serial real-time clock (RTC) with alarm
 stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
 taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
-ti,tsc2003		I2C Touch-Screen Controller
+ti,bq27200		Battery Monitor
+ti,bq27500		Battery Monitor
+ti,bq27425		Battery Monitor
 ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
 ti,tmp275		Digital Temperature Sensor
+ti,tsc2003		I2C Touch-Screen Controller
-- 
1.8.4.rc3
