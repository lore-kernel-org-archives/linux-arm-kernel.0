From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 02:02:12 +0200
Subject: [PATCH 0/6] Dove fixes for arm-soc/for-next
Message-ID: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the current speed of changes within arm kernel tree, there
have been some issues related to the mach-dove DT support patches
introduced lately. This patch set keeps up with the changes between
initial patch submission and current status of arm-soc/for-next.

Sebastian Hesselbarth (6):
  ARM: dove: Add pcie clock support
  ARM: dove: Fix tauros2 device tree init
  ARM: dove: Fix clock names of sata and gbe
  ARM: dove: Restructure SoC device tree descriptor
  ARM: dove: Remove watchdog from DT
  ARM: dove: Add crypto engine to DT

 arch/arm/boot/dts/dove.dtsi |   49 ++++++++++++++++++++++++++++---------------
 arch/arm/mach-dove/common.c |    8 +++----
 arch/arm/mach-dove/pcie.c   |    5 +++++
 3 files changed, 41 insertions(+), 21 deletions(-)

---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.10.4
