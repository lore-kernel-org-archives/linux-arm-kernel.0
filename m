From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Jan 2011 16:09:42 +0900
Subject: [GIT PULL] Samsung S5P fixes
Message-ID: <03f401cbb6de$b12a85a0$137f90e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull Samsung fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

These things had build problem with sound tree so couldn't merge it.
Its dependency has disappeared in mainline now so I'm requesting pull this.
Of course, it would be nice to see your merging this in before -rc1 :-)

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit e6f597a1425b5af64917be3448b29e2d5a585ac8:

 staging: fix build failure in bcm driver (2011-01-17 16:11:12 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

Jassi Brar (5):
      ARM: S5P6442: Enable I2S device to work on SMDK6442
      ARM: S5P6440: Add missing virtual ASoC DMA device
      ARM: S5P6450: Add missing virtual ASoC DMA device
      ARM: S5PV210: Add missing virtual ASoC DMA device
      ARM: S5PV310: Add missing virtual ASoC DMA device

 arch/arm/mach-s5p6442/mach-smdk6442.c |    1 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c |    1 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c |    1 +
 arch/arm/mach-s5pv210/mach-smdkc110.c |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c |    1 +
 arch/arm/mach-s5pv310/mach-smdkc210.c |    3 ++-
 arch/arm/mach-s5pv310/mach-smdkv310.c |    3 ++-
 7 files changed, 9 insertions(+), 2 deletions(-)
