From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 2 Jun 2014 14:53:18 +0530
Subject: [Pull Request] Various ARM platform code fixes
Message-ID: <CAK9yfHw=zecLHWHVZWvf3PzphYG3CDyTwMRXicUUFM4kkhT9Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

As suggested by you I am sending a pull request for the below 8 patches.
These are based on for-next branch of arm-soc tree [1].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git



The following changes since commit f8175c74fd39ccc336391a9491fc0353d6f92b90:

  Merge branch 'next/soc' into for-next (2014-05-31 10:20:56 -0700)

are available in the git repository at:


  git://git.linaro.org/people/sachin.kamat/linux-common-kernel.git arm-soc

for you to fetch changes up to 545ce3a27284b231fca8ea09cc3e37d66793b56f:

  ARM: spear: Staticize local symbols in spear1340.c (2014-06-02 13:56:58 +0530)

----------------------------------------------------------------
Sachin Kamat (8):
      ARM: sti: Staticize local variables
      ARM: mvebu: Staticize armada_375_smp_cpu1_enable_wa
      ARM: mvebu: Staticize armada_370_xp_cpu_pm_init
      ARM: mvebu: Staticize mvebu_cpu_reset_init
      ARM: vt8500: Staticize local symbols
      ARM: spear: Staticize spear13xx_io_desc
      ARM: spear: Staticize spear1310_io_desc in spear1310.c
      ARM: spear: Staticize local symbols in spear1340.c

 arch/arm/mach-mvebu/cpu-reset.c  |    2 +-
 arch/arm/mach-mvebu/platsmp-a9.c |    2 +-
 arch/arm/mach-mvebu/pmsu.c       |    2 +-
 arch/arm/mach-spear/spear1310.c  |    2 +-
 arch/arm/mach-spear/spear1340.c  |    6 +++---
 arch/arm/mach-spear/spear13xx.c  |    2 +-
 arch/arm/mach-sti/platsmp.c      |    6 +++---
 arch/arm/mach-vt8500/vt8500.c    |    6 +++---
 8 files changed, 14 insertions(+), 14 deletions(-)

-- 
With warm regards,
Sachin
