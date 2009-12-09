From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Dec 2009 10:09:09 +0000
Subject: [GIT PULL] Patches for 2.6.33-rc1
Message-ID: <1260353349.13499.4.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

There are some patches which were not pulled yet and it would be nice if
they get in during this merging window. Two of them are bug-fixes and
the other is the earlyprintk support which many people find useful.

My for-rmk branch was rebased to 2.6.32 to check what was already merged
but I can rebase it something earlier if you want.

Thanks.


The following changes since commit 22763c5cf3690a681551162c15d34d935308c8d7:
  Linus Torvalds (1):
        Linux 2.6.32

are available in the git repository at:

  git://linux-arm.org/linux-2.6.git for-rmk

Catalin Marinas (2):
      Add an earlyprintk debug console
      RealView: Fix typo in the Kconfig enabling SPARSEMEM for RealView/PBX

Varun Swara (1):
      Do not allow the probing of the local timer

 arch/arm/Kconfig.debug         |    8 +++++
 arch/arm/kernel/Makefile       |    1 +
 arch/arm/kernel/early_printk.c |   57 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp_twd.c      |    1 +
 arch/arm/mach-realview/Kconfig |    2 +-
 5 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/kernel/early_printk.c

-- 
Catalin
