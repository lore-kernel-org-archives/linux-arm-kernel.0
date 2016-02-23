From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 23 Feb 2016 15:23:33 +0530
Subject: [GIT PULL] DaVinci fixes for v4.6
Message-ID: <1456221214-18042-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.6/fixes

for you to fetch changes up to 8e58041114319ad290e85a7a82077dc9e2f93613:

  ARM: davinci: make I2C support optional (2016-02-17 19:20:05 +0530)

----------------------------------------------------------------
Warning fixes for DaVinci collected while testing
randconfig builds.

----------------------------------------------------------------
Arnd Bergmann (4):
      ARM: davinci: limit DT support to DA850
      ARM: davinci: avoid unused mityomapl138_pn_info variable
      ARM: davinci: DA8xx+DMx combined kernels need PATCH_PHYS_VIRT
      ARM: davinci: make I2C support optional

 arch/arm/Kconfig                           |  1 +
 arch/arm/mach-davinci/Kconfig              | 22 ++++------------------
 arch/arm/mach-davinci/board-dm644x-evm.c   |  8 ++++++--
 arch/arm/mach-davinci/board-dm646x-evm.c   |  7 +++++++
 arch/arm/mach-davinci/board-mityomapl138.c |  2 +-
 5 files changed, 19 insertions(+), 21 deletions(-)
