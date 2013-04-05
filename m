From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Apr 2013 15:30:17 +0530
Subject: [GIT PULL 3/3] DaVinci board updates for v3.10
In-Reply-To: <1365156017-12149-1-git-send-email-nsekhar@ti.com>
References: <1365156017-12149-1-git-send-email-nsekhar@ti.com>
Message-ID: <1365156017-12149-3-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.10/board

for you to fetch changes up to a0a56db9771f57667daff41cfa2546dad1abe6d9:

  ARM: davinci: use is IS_ENABLED macro (2013-04-02 15:31:15 +0530)

----------------------------------------------------------------
v3.10 board updates for DaVinci

This pull request enables CGROUPS in defconfig and also
cleans up mach-davinci to use IS_ENABLED() macro.

----------------------------------------------------------------
Lad, Prabhakar (1):
      ARM: davinci: use is IS_ENABLED macro

Sekhar Nori (1):
      ARM: davinci: defconfig: enable CGROUPS

 arch/arm/configs/da8xx_omapl_defconfig    |    1 +
 arch/arm/configs/davinci_all_defconfig    |    1 +
 arch/arm/mach-davinci/board-da830-evm.c   |    6 +-----
 arch/arm/mach-davinci/board-da850-evm.c   |    7 +------
 arch/arm/mach-davinci/board-dm644x-evm.c  |   25 +++++--------------------
 arch/arm/mach-davinci/board-dm646x-evm.c  |    7 +------
 arch/arm/mach-davinci/board-neuros-osd2.c |   15 ++-------------
 arch/arm/mach-davinci/devices.c           |    2 +-
 arch/arm/mach-davinci/usb.c               |    2 +-
 9 files changed, 14 insertions(+), 52 deletions(-)
