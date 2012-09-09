From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 9 Sep 2012 20:08:11 +0800
Subject: [GIT PULL][for 3.7] pull request of clk branch in arch-pxa git tree
Message-ID: <CAN1soZzAxZR6245WO8dNHABiKo+frBKW0Tfx1Tk856HCcA0eSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to merge patches from clk branch of arch pxa git tree.

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git clk

for you to fetch changes up to 7f744b17140af1a9c8804a1c81c9dae6bb52a7fb:

  ARM: mmp: remove unused definition in APBC and APMU (2012-09-08
23:40:09 +0800)

----------------------------------------------------------------
Chao Xie (5):
      arm: mmp: make private clock definition exclude from common clock
      arm: mmp: move pxa168 clock definition to separated file
      arm: mmp: move pxa910 clock definition to separated file
      ARM: mmp: move mmp2 clock definition to separated file
      ARM: mmp: remove unused definition in APBC and APMU

 arch/arm/mach-mmp/Makefile                 |    8 +-
 arch/arm/mach-mmp/clock-mmp2.c             |  111 ++++++++++++++++++++++++++++
 arch/arm/mach-mmp/clock-pxa168.c           |   91 +++++++++++++++++++++++
 arch/arm/mach-mmp/clock-pxa910.c           |   67 +++++++++++++++++
 arch/arm/mach-mmp/common.h                 |    3 +
 arch/arm/mach-mmp/include/mach/regs-apbc.h |   95 ------------------------
 arch/arm/mach-mmp/include/mach/regs-apmu.h |   15 ----
 arch/arm/mach-mmp/mmp2.c                   |   71 ++----------------
 arch/arm/mach-mmp/pxa168.c                 |   58 ++-------------
 arch/arm/mach-mmp/pxa910.c                 |   40 +---------
 10 files changed, 293 insertions(+), 266 deletions(-)
 create mode 100644 arch/arm/mach-mmp/clock-mmp2.c
 create mode 100644 arch/arm/mach-mmp/clock-pxa168.c
 create mode 100644 arch/arm/mach-mmp/clock-pxa910.c
