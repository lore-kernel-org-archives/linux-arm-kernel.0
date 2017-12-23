From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 23 Dec 2017 21:21:31 +0530
Subject: [GIT PULL] TI DaVinci SoC support updates for v4.16
Message-ID: <20171223155131.5078-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.16/soc

for you to fetch changes up to ed3c0c2b4fdcbe05194ee3f5e634ece3018d3b76:

  ARM: dts: da850-lcdk: Remove leading 0x and 0s from unit address (2017-12-23 15:46:25 +0530)

----------------------------------------------------------------
DaVinci SoC updates consisting of non-critical bug fixes including constifying
data structures, DT warning fixes for W=1 and code simplification.

Also a defconfig update for DaVinci, enabling support for USB network adaptors.

----------------------------------------------------------------
Aparna Balasubramanian (1):
      ARM: davinci_all_defconfig: enable support for USB network adaptors

Bhumika Goyal (2):
      ARM: davinci: make argument to davinci_common_init() as const
      ARM: davinci: make davinci_soc_info structures const

Mathieu Malaterre (1):
      ARM: dts: da850-lcdk: Remove leading 0x and 0s from unit address

Vasyl Gomonovych (1):
      ARM: davinci: Use PTR_ERR_OR_ZERO()

 arch/arm/boot/dts/da850-lcdk.dts            | 4 ++--
 arch/arm/configs/davinci_all_defconfig      | 1 +
 arch/arm/mach-davinci/common.c              | 2 +-
 arch/arm/mach-davinci/da830.c               | 2 +-
 arch/arm/mach-davinci/da850.c               | 2 +-
 arch/arm/mach-davinci/devices-da8xx.c       | 4 ++--
 arch/arm/mach-davinci/dm355.c               | 2 +-
 arch/arm/mach-davinci/dm365.c               | 2 +-
 arch/arm/mach-davinci/dm644x.c              | 2 +-
 arch/arm/mach-davinci/dm646x.c              | 4 ++--
 arch/arm/mach-davinci/include/mach/common.h | 2 +-
 11 files changed, 14 insertions(+), 13 deletions(-)
