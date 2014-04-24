From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Apr 2014 11:42:18 -0400
Subject: [PATCH 0/4] ARM: keystone: Use coherent higher memory address space
Message-ID: <1398354142-2767-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of theses have been already posted in past as part of different series.
The late code patching is already merged which means no dependency for patch 1
to be merged and the ongoing dma-ranges series makes it complete for me to
enable coherency on Keystone SOCs.

Grygorii Strashko (1):
  ARM: dts: keystone: Use dma-ranges property

Santosh Shilimkar (3):
  ARM: keystone: Switch over to coherent memory address space
  ARM: keystone: Update the dma offset for non-dt platform devices
  ARM: dts: keystone: Update USB node for dma properties

 arch/arm/boot/dts/keystone.dtsi   |    3 ++
 arch/arm/mach-keystone/keystone.c |   74 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-keystone/memory.h   |   24 ++++++++++++
 arch/arm/mach-keystone/platsmp.c  |   18 ++++++++-
 4 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-keystone/memory.h

-- 
1.7.9.5
