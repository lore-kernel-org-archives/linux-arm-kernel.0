From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 9 Jul 2012 15:31:21 +0530
Subject: [GIT PULL] DaVinci cleanup for v3.6
Message-ID: <4FFAABF1.70902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following DaVinci clean-up for v3.6

Thanks,
Sekhar

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-v3.6-cleanup

for you to fetch changes up to 13429ced25fdca14b28dbd116333262b0d51d10f:

  ARM: davinci: remove dummy header files (2012-06-18 21:39:27 +0530)

----------------------------------------------------------------
DaVinci cleanups for v3.6

Remove some header files which were marked for removal. These files are
not used anymore.

----------------------------------------------------------------
Paul Bolle (1):
      ARM: davinci: remove dummy header files

 arch/arm/mach-davinci/include/mach/dm365.h  |    1 -
 arch/arm/mach-davinci/include/mach/dm646x.h |    1 -
 2 files changed, 2 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm646x.h
