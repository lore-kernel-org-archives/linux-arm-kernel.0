From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Aug 2012 10:45:11 -0700
Subject: [GIT PULL 1/3] ARM: SoC fixes
Message-ID: <CAOesGMiBPVtYwMN2o-e_vBC_XOdgjuDfrBs-ftAByvfdCsrB3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few fixes for merge window fallout, and a bugfix for timer resume
on PRIMA2.

----------------------------------------------------------------

The following changes since commit 1a9b4993b70fb1884716902774dc9025b457760d:

  Merge branch 'upstream' of
git://git.linux-mips.org/pub/scm/ralf/upstream-linus

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/fixes-for-linus

for you to fetch changes up to bac6f61550043195ee59e9cef0db67af23baf11e:

  ARM: mmp: add missing irqs.h

----------------------------------------------------------------

Barry Song (1):
      ARM: PRIMA2: delete redundant codes to restore LATCHED when timer resumes

Fabio Estevam (1):
      ARM: mxc: Include missing irqs.h header

Haojian Zhuang (1):
      ARM: mmp: add missing irqs.h

Thomas Petazzoni (1):
      arm: mvebu: fix typo in .dtsi comment for Armada XP SoCs


 arch/arm/boot/dts/armada-xp.dtsi | 2 +-
 arch/arm/mach-mmp/gplugd.c       | 1 +
 arch/arm/mach-prima2/timer.c     | 6 +++---
 arch/arm/plat-mxc/tzic.c         | 1 +
 4 files changed, 6 insertions(+), 4 deletions(-)
