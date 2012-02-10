From: robherring2@gmail.com (Rob Herring)
Date: Fri, 10 Feb 2012 09:52:56 -0600
Subject: [PULL] Highbank for 3.4
Message-ID: <4F353D58.5050101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull highbank changes for 3.4. It's primarily just sched_clock
support.

Rob

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git for-arm-soc

Rob Herring (3):
      ARM: timer-sp: add sched_clock support
      ARM: highbank: enable sp804 based sched_clock
      ARM: highbank: remove unused memory.h

 arch/arm/Kconfig                             |    1 +
 arch/arm/common/timer-sp.c                   |   17 ++++++++++++++++-
 arch/arm/include/asm/hardware/timer-sp.h     |   15 ++++++++++++++-
 arch/arm/mach-highbank/highbank.c            |    2 +-
 arch/arm/mach-highbank/include/mach/memory.h |    1 -
 5 files changed, 32 insertions(+), 4 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/include/mach/memory.h
