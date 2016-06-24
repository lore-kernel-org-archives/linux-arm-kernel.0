From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 24 Jun 2016 17:51:42 +0530
Subject: [GIT PULL] DaVinci updates for v4.8
Message-ID: <576D25D6.7090907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.8

for you to fetch changes up to 6bce5efd442488434a317a25c5482fcd5a66bb0f:

  ARM: davinci: remove unused davinci-i2s pdata (2016-06-24 15:28:30 +0530)

----------------------------------------------------------------
Clean-up unused pdata for DaVinci McBSP
audio driver and add McBSP clocks for
DaVinci DA850 SoC.

----------------------------------------------------------------
Petr Kulhavy (2):
      ARM: davinci: da850: add clocks for mcbsp0 and 1
      ARM: davinci: remove unused davinci-i2s pdata

 arch/arm/mach-davinci/board-dm355-evm.c   |  4 +---
 arch/arm/mach-davinci/board-dm365-evm.c   |  6 +-----
 arch/arm/mach-davinci/board-dm644x-evm.c  |  4 +---
 arch/arm/mach-davinci/board-neuros-osd2.c |  4 +---
 arch/arm/mach-davinci/da850.c             | 16 ++++++++++++++++
 arch/arm/mach-davinci/davinci.h           |  6 +++---
 arch/arm/mach-davinci/dm355.c             |  3 +--
 arch/arm/mach-davinci/dm365.c             |  3 +--
 arch/arm/mach-davinci/dm644x.c            |  3 +--
 arch/arm/mach-davinci/psc.h               |  2 ++
 10 files changed, 28 insertions(+), 23 deletions(-)
