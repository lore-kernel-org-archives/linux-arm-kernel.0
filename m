From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 14 May 2012 09:42:06 +0800
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in arch-pxa
Message-ID: <CAN1soZyM-YQ9EX66EY_fTwPncokra9NpB6QEZ2ExCGizKk9MAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to merge board-specific branch in arch-pxa git tree.

The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:

  Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git board-specific

Axel Lin (1):
      ARM: pxa: Use REGULATOR_SUPPLY macro

Paul Parsons (1):
      ARM: pxa: hx4700: Add Synaptics NavPoint touchpad

 arch/arm/mach-pxa/balloon3.c                |    4 +--
 arch/arm/mach-pxa/cm-x300.c                 |    4 +--
 arch/arm/mach-pxa/em-x270.c                 |    5 +---
 arch/arm/mach-pxa/hx4700.c                  |   37 +++++++++++++++++++-------
 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    1 +
 arch/arm/mach-pxa/magician.c                |    8 +----
 arch/arm/mach-pxa/mioa701.c                 |    4 +--
 arch/arm/mach-pxa/palm27x.c                 |    4 +--
 arch/arm/mach-pxa/spitz.c                   |    4 +--
 arch/arm/mach-pxa/stargate2.c               |    5 +---
 arch/arm/mach-pxa/vpac270.c                 |    4 +--
 arch/arm/mach-pxa/z2.c                      |    4 +--
 12 files changed, 39 insertions(+), 45 deletions(-)


Regards
Haojian
