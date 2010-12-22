From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 22 Dec 2010 14:03:52 +0000
Subject: [PATCH 0/6] Series short description
Message-ID: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements...

---

Colin Tuckley (6):
      ARM Realview PCIX build file changes
      ARM Realview PCIX board file changes
      ARM Realview PCIX IRQ include file changes
      ARM Realview PCIX map include file changes
      Realview PCIX support - add main support module code
      ARM: enable bridges in pci_common_init.


 arch/arm/Kconfig                                   |    6 
 arch/arm/kernel/bios32.c                           |    5 
 arch/arm/mach-realview/Makefile                    |    6 
 arch/arm/mach-realview/include/mach/board-pb11mp.h |   11 
 arch/arm/mach-realview/include/mach/board-pba8.h   |   11 
 arch/arm/mach-realview/include/mach/board-pbx.h    |   11 
 arch/arm/mach-realview/include/mach/hardware.h     |   53 ++
 arch/arm/mach-realview/include/mach/io.h           |   18 +
 arch/arm/mach-realview/include/mach/irqs-pb11mp.h  |   11 
 arch/arm/mach-realview/include/mach/irqs-pba8.h    |    7 
 arch/arm/mach-realview/include/mach/irqs-pbx.h     |    7 
 arch/arm/mach-realview/include/mach/platform.h     |   15 -
 arch/arm/mach-realview/pcix.c                      |  503 ++++++++++++++++++++
 arch/arm/mach-realview/realview_pb11mp.c           |   18 +
 arch/arm/mach-realview/realview_pba8.c             |   18 +
 arch/arm/mach-realview/realview_pbx.c              |   16 +
 16 files changed, 659 insertions(+), 57 deletions(-)
 create mode 100755 arch/arm/mach-realview/pcix.c

-- 
Signature
