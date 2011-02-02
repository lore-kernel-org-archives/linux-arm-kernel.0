From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 2 Feb 2011 22:03:59 +0000
Subject: [PATCH 0/2] ARM: add support for QQ2440 board
Message-ID: <20110202220359.GA2808@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

QQ2440 is a Samsung S3C2440 based development board. It's equipped with
64MB of RAM, 64MB of NAND flash, 2MB of NOR flash, 3x serial ports, 1x
USB host, 1x USB device, 1x 10Mbit LAN RJ45, 1x SD card, 1x LCD display,
1x camera.

This patch series adds support for everything but the LCD and camera. It
applies cleanly to 2.6.37 and 2.6.38-rc3.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---
 MAINTAINERS                                 |    7 
 arch/arm/mach-s3c2440/Kconfig               |   12 
 arch/arm/mach-s3c2440/Makefile              |    1 
 arch/arm/mach-s3c2440/include/mach/qq2440.h |   22 +
 arch/arm/mach-s3c2440/mach-qq2440.c         |  374 +++++++++++++++++-
 drivers/net/Kconfig                         |    4 
 drivers/net/cs89x0.c                        |   33 +
 7 files changed, 439 insertions(+), 14 deletions(-)

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
