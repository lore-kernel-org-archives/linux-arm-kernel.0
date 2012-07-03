From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarth)
Date: Tue,  3 Jul 2012 14:34:23 +0200
Subject: [PATCH 0/3] ARM: dts: dove: Basic devicetree support for Marvell Dove
Message-ID: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add very basic devicetree support for Marvell Dove.
It is based on Kirkwood dts and therefore supports uart and rtc by
dt only.

The patches have not been tested on neither Dove-DB nor CM-A510 but
on SolidRun Cubox that is not supported by mainline kernel, yet.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org

Sebastian Hesselbarth (3):
  ARM: dts: dove: Add devicetree descriptors
  ARM: dts: dove: Add devicetree-based board setup
  ARM: dts: dove: Integrate devicetree support

 arch/arm/boot/dts/dove-cm-a510.dtsi |   27 ++++++++++
 arch/arm/boot/dts/dove-dove-db.dtsi |   27 ++++++++++
 arch/arm/boot/dts/dove.dtsi         |   55 +++++++++++++++++++++
 arch/arm/mach-dove/Kconfig          |   20 ++++++++
 arch/arm/mach-dove/Makefile         |    4 ++
 arch/arm/mach-dove/Makefile.boot    |    3 ++
 arch/arm/mach-dove/board-cm-a510.c  |   86 ++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/board-dove-db.c  |   92 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/board-dt.c       |   73 +++++++++++++++++++++++++++
 arch/arm/mach-dove/common.c         |   17 ++++---
 arch/arm/mach-dove/common.h         |   25 ++++++++++
 12 files changed, 444 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-dove-db.dtsi
 create mode 100644 arch/arm/boot/dts/dove.dtsi
 create mode 100644 arch/arm/mach-dove/board-cm-a510.c
 create mode 100644 arch/arm/mach-dove/board-dove-db.c
 create mode 100644 arch/arm/mach-dove/board-dt.c

-- 
1.7.10
