From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Jan 2018 20:22:47 +0530
Subject: [GIT PULL v2 1/2] TI DaVinci SoC support updates for v4.16
Message-ID: <20180105145248.1994-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.16/soc-v2

for you to fetch changes up to 23bbeaef90ab7607d03428bbb708efe44f43c761:

  ARM: davinci: constify gpio_led (2018-01-05 19:28:41 +0530)

----------------------------------------------------------------
DaVinci SoC updates consisting of non-critical bug fixes including constifying
data structures, removal of unnecessary newlines from gpio labels and code
simplification.

Also a defconfig update for DaVinci, enabling support for USB network adaptors.

----------------------------------------------------------------
Aparna Balasubramanian (1):
      ARM: davinci_all_defconfig: enable support for USB network adaptors

Arvind Yadav (1):
      ARM: davinci: constify gpio_led

Bhumika Goyal (2):
      ARM: davinci: make argument to davinci_common_init() as const
      ARM: davinci: make davinci_soc_info structures const

Julia Lawall (1):
      ARM: davinci: drop unneeded newline

Vasyl Gomonovych (1):
      ARM: davinci: Use PTR_ERR_OR_ZERO()

 arch/arm/configs/davinci_all_defconfig      | 1 +
 arch/arm/mach-davinci/board-da850-evm.c     | 4 ++--
 arch/arm/mach-davinci/board-neuros-osd2.c   | 2 +-
 arch/arm/mach-davinci/common.c              | 2 +-
 arch/arm/mach-davinci/da830.c               | 2 +-
 arch/arm/mach-davinci/da850.c               | 2 +-
 arch/arm/mach-davinci/devices-da8xx.c       | 4 ++--
 arch/arm/mach-davinci/dm355.c               | 2 +-
 arch/arm/mach-davinci/dm365.c               | 2 +-
 arch/arm/mach-davinci/dm644x.c              | 2 +-
 arch/arm/mach-davinci/dm646x.c              | 4 ++--
 arch/arm/mach-davinci/include/mach/common.h | 2 +-
 12 files changed, 15 insertions(+), 14 deletions(-)
