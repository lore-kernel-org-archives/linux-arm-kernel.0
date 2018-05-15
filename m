From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 May 2018 14:52:14 +0530
Subject: [GIT PULL] DaVinci fixes for v4.17 (part 2)
Message-ID: <fcf8613b-31df-733b-3443-c1a6176cbdd1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9411ac07cd764be34bbd7ff09125a6b7b9175d4c:

  ARM: davinci: fix GPIO lookup for I2C (2018-05-02 14:55:06 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.17-part-2

for you to fetch changes up to bb7298a7e87cf3430eb62be8746e5d7a07ca9d7c:

  ARM: davinci: board-dm646x-evm: set VPIF capture card name (2018-05-15 14:31:12 +0530)

----------------------------------------------------------------
Second set of fixes for TI DaVinci.

They are needed for DM6467 EVM to work. The first patch fixes an
issue with timer interrupt and the second two are needed for video
driver to probe successfully.

----------------------------------------------------------------
Sekhar Nori (3):
      ARM: davinci: dm646x: fix timer interrupt generation
      ARM: davinci: board-dm646x-evm: pass correct I2C adapter id for VPIF
      ARM: davinci: board-dm646x-evm: set VPIF capture card name

 arch/arm/mach-davinci/board-dm646x-evm.c | 5 ++++-
 arch/arm/mach-davinci/dm646x.c           | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)
