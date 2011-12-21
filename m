From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Wed, 21 Dec 2011 16:45:22 +0900
Subject: Pull Requeset: Exynos4 Register Address Update for Devfreq Drivers.
Message-ID: <CAJ0PZbQ1=+BTs0Emi78kfOWD5d90+ND5Jc_SJ9T4BcGMXyny9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Please pull the patches for Exynos4 SoCs that support devfreq device
drivers for Exynos4210/4212/4412.

The patches are:
ARM: EXYNOS4: Add DMC1, allow PPMU access for DMC.
ARM: EXYNOS4: Add clock register addresses for Exynos4x12 bus devfreq driver
ARM Exynos4210-Nuri: support Exynos4210-bus Devfreq driver.

Gitweb: http://git.infradead.org/users/kmpark/linux-samsung/shortlog/refs/heads/devfreq-for-samsung
Git Repository: git://git.infradead.org/users/kmpark/linux-samsung
Branch: devfreq-for-samsung

The following changes since commit 390f998509bf049019df0b078c0a6606e0d57fb4:

Merge: e34d6b4 6f6c2aa
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Dec 18 14:28:31 2011 -0800

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6
(2011-12-18 14:28:31 -0800)

are available in the git repository at:

  git://git.infradead.org/users/kmpark/linux-samsung.git devfreq-for-samsung

MyungJoo Ham (3):
      ARM: EXYNOS4: Add DMC1, allow PPMU access for DMC.
      ARM: EXYNOS4: Add clock register addresses for Exynos4x12 bus
devfreq driver
      ARM Exynos4210-Nuri: support Exynos4210-bus Devfreq driver.

 arch/arm/mach-exynos/cpu.c                     |    7 +++-
 arch/arm/mach-exynos/include/mach/map.h        |    1 +
 arch/arm/mach-exynos/include/mach/regs-clock.h |   42 ++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-nuri.c               |   11 ++++--
 4 files changed, 57 insertions(+), 4 deletions(-)



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
