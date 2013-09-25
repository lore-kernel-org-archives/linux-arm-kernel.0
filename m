From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 25 Sep 2013 05:36:17 +0530
Subject: [GIT PULL] DaVinci SoC updates for v3.13
Message-ID: <524228F9.50104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.13/soc

for you to fetch changes up to 5093f84e708574142ce26fa4a6c4558176436c86:

  ARM: edma: dt: create unused channel list (2013-09-25 05:04:28 +0530)

----------------------------------------------------------------
This pull request contains a patch to remove
a long deprecated irq flag and completes the
DT support in EDMA library.

----------------------------------------------------------------
Joel Fernandes (1):
      ARM: edma: dt: create unused channel list

Michael Opdenacker (1):
      ARM: davinci: remove deprecated IRQF_DISABLED

 arch/arm/common/edma.c                      |   39 ++++++++++++++++++++++-----
 arch/arm/mach-davinci/board-da830-evm.c     |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    2 +-
 arch/arm/mach-davinci/time.c                |    4 +--
 4 files changed, 36 insertions(+), 11 deletions(-)
