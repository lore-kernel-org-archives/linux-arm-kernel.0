From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  2 Mar 2014 16:24:13 +0100
Subject: =?UTF-8?q?=5BPATCH=201/3=5D=20DT=3A=20I2C=3A=20Add=20trivial=20bindings=20used=20by=20kirkwood=20boards?=
Message-ID: <1393773855-9592-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a number of eeproms and temperature sensors/fan controllers used
by kirkwood boards.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/i2c/trivial-devices.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index e11ed0fe770c..7faa3eab2549 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -13,7 +13,22 @@ ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert an
 ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
 adi,adt7461		+/-1C TDM Extended Temp Range I.C
 adt7461			+/-1C TDM Extended Temp Range I.C
+adi,adt7473		+/-1C TDM Extended Temp Range I.C
+adi,adt7475		+/-1C TDM Extended Temp Range I.C
+adi,adt7476		+/-1C TDM Extended Temp Range I.C
+adi,adt7490		+/-1C TDM Extended Temp Range I.C
+at,24c00		i2c serial eeprom  (24cxx)
+at,24c01		i2c serial eeprom  (24cxx)
+at,24c02		i2c serial eeprom  (24cxx)
+at,24c04		i2c serial eeprom  (24cxx)
 at,24c08		i2c serial eeprom  (24cxx)
+at,24c16		i2c serial eeprom  (24cxx)
+at,24c32		i2c serial eeprom  (24cxx)
+at,24c64		i2c serial eeprom  (24cxx)
+at,24c128		i2c serial eeprom  (24cxx)
+at,24c256		i2c serial eeprom  (24cxx)
+at,24c512		i2c serial eeprom  (24cxx)
+at,24c1024		i2c serial eeprom  (24cxx)
 atmel,24c02		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
@@ -45,8 +60,10 @@ maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I?C-Compatible Serial Interface
 mc,rv3029c2		Real Time Clock Module with I2C-Bus
+national,lm63		Temperature sensor with integrated fan control
 national,lm75		I2C TEMP SENSOR
 national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
+national,lm85		Temperature sensor with integrated fan control
 national,lm92		?0.33?C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator with Two-Wire Interface
 nuvoton,npct501		i2c trusted platform module (TPM)
 nxp,pca9556		Octal SMBus and I2C registered interface
-- 
1.8.5.3
