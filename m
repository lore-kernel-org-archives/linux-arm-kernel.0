From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Nov 2010 02:23:48 +0800
Subject: [GIT PULL] pxa fixes for v2.6.37-rc1
Message-ID: <AANLkTikW1pUx5xXkZLPw2v6Q1M3J75=R48M5b_BCLpCC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

The following changes since commit c8ddb2713c624f432fa5fe3c7ecffcdda46ea0d4:

  Linux 2.6.37-rc1 (2010-11-01 07:54:12 -0400)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Eric Miao (2):
      ARM: pxa: fix the missing definition of IRQ_BOARD_END
      ARM: pxa/saar: fix the building failure caused by typo

Haojian Zhuang (1):
      ARM: mmp: fix cpuid detection on mmp2

Mike Rapoport (1):
      ARM: pxa/cm-x2xx: remove duplicate call to pxa27x_init_irq

 arch/arm/include/asm/hardware/it8152.h   |    2 +-
 arch/arm/mach-mmp/include/mach/cputype.h |    3 ++-
 arch/arm/mach-pxa/cm-x2xx.c              |    2 --
 arch/arm/mach-pxa/saar.c                 |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
