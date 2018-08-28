From: dantuguf14105@gmail.com (Neeraj Dantu)
Date: Tue, 28 Aug 2018 15:38:16 +0000
Subject: [PATCH] Fix file permission for am335x-osd3358-sm-red.dts
Message-ID: <20180828153816.1152-1-neeraj.dantu@octavosystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
Octavo Systems.

This board family can be indentified by the A335BNLTOS00 in the at24 eeprom:
A2: [aa 55 33 ee 41 33 33 35  42 4e 4c 54 4f 53 30 30 |.U3.A335BNLTOS00|]

https://octavosystems.com/octavo_products/osd3358-sm-red/

Signed-off-by: Neeraj Dantu <neeraj.dantu@octavosystems.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Robert Nelson <robertcnelson@gmail.com>
CC: Jason Kridner <jkridner@gmail.com>
---
Changes:
- Fix file permission
---
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts

diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
old mode 100755
new mode 100644
-- 
2.7.4
