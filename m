From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 20 Aug 2012 13:55:23 +0800
Subject: [GIT PULL][for 3.7] pull request for pxa/dt branch in arm-soc from
 arch-pxa git tree
Message-ID: <CAN1soZwqoOvk3f7jzQUbza3PH2houwE4ERFJFn480F9yzBqm_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to merge these three patches into pxa/dt branch. Since
they're depend
on existing patch on pxa/dt branch, I didn't do rebase on v3.6-rc2.

Regards
Haojian

The following changes since commit 51931b37fcb17a2f48f726fd21b88e3af770ddc2:

  ARM: mmp: enable tauros2 cache in mmp2 dt (2012-08-16 16:17:10 +0800)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git dt

for you to fetch changes up to e6c509c8ef85155bf504254399d758384a3b2e38:

  ARM: pxa: fix build issue while CONFIG_OF is disabled (2012-08-20
13:52:05 +0800)

----------------------------------------------------------------
Haojian Zhuang (3):
      ARM: pxa: append the definition of CKENC
      mtd: nand: append missing parameter and value
      ARM: pxa: fix build issue while CONFIG_OF is disabled

 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h |    1 +
 arch/arm/mach-pxa/pxa3xx.c                   |    2 ++
 drivers/mtd/nand/pxa3xx_nand.c               |    4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)
