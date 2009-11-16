From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Nov 2009 10:34:54 +0000
Subject: [GIT PULL] Patches for 2.6.33
Message-ID: <1258367694.6705.16.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Since the last pull from my branch there were four additional patches
discussed on the list. Would you consider pulling (any of) them for
2.6.33?

Thanks.


The following changes since commit c97c5aa83c41a532bc67da356d77da929bc41b9c:
  Catalin Marinas (1):
        RealView: Add sparsemem support for the RealView PBX platform

are available in the git repository at:

  git://linux-arm.org/linux-2.6.git for-rmk

Catalin Marinas (3):
      Fix the machine description printing in __error_a
      Add an earlyprintk debug console
      ARMv7: Use lazy cache flushing if hardware broadcasts cache operations

Varun Swara (1):
      Do not allow the probing of the local timer

 arch/arm/Kconfig.debug          |    8 +++++
 arch/arm/include/asm/smp_plat.h |    9 ++++++
 arch/arm/kernel/Makefile        |    1 +
 arch/arm/kernel/early_printk.c  |   57 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/head-common.S   |    2 +-
 arch/arm/kernel/smp_twd.c       |    1 +
 arch/arm/mm/fault-armv.c        |    2 -
 arch/arm/mm/flush.c             |    9 +++---
 8 files changed, 81 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/kernel/early_printk.c

-- 
Catalin
