From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Mar 2014 13:45:59 +0100
Subject: =?UTF-8?q?=5BPATCH=204/5=5D=20DT=3A=20I2C=3A=20Add=20trivial=20bindings=20used=20by=20kirkwood=20boards?=
In-Reply-To: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
References: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
Message-ID: <1395492360-1865-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a number of eeproms and temperature sensors/fan controllers used
by kirkwood boards.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/i2c/trivial-devices.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 71724d026ffa..bef86e57c388 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -15,4 +15,18 @@ adi,adt7461		+/-1C TDM Extended Temp Range I.C
 adt7461			+/-1C TDM Extended Temp Range I.C
+adi,adt7473		+/-1C TDM Extended Temp Range I.C
+adi,adt7475		+/-1C TDM Extended Temp Range I.C
+adi,adt7476		+/-1C TDM Extended Temp Range I.C
+adi,adt7490		+/-1C TDM Extended Temp Range I.C
 at,24c08		i2c serial eeprom  (24cxx)
+atmel,24c00		i2c serial eeprom  (24cxx)
+atmel,24c01		i2c serial eeprom  (24cxx)
 atmel,24c02		i2c serial eeprom  (24cxx)
+atmel,24c04		i2c serial eeprom  (24cxx)
+atmel,24c16		i2c serial eeprom  (24cxx)
+atmel,24c32		i2c serial eeprom  (24cxx)
+atmel,24c64		i2c serial eeprom  (24cxx)
+atmel,24c128		i2c serial eeprom  (24cxx)
+atmel,24c256		i2c serial eeprom  (24cxx)
+atmel,24c512		i2c serial eeprom  (24cxx)
+atmel,24c1024		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
@@ -48,4 +62,6 @@ maxim,max6625		9-Bit/12-Bit Temperature Sensors with I?C-Compatible Serial Inte
 mc,rv3029c2		Real Time Clock Module with I2C-Bus
+national,lm63		Temperature sensor with integrated fan control
 national,lm75		I2C TEMP SENSOR
 national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
+national,lm85		Temperature sensor with integrated fan control
 national,lm92		?0.33?C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator with Two-Wire Interface
-- 
1.9.1
