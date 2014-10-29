From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 14:00:05 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Soc Cleanups for v3.19
Message-ID: <cover.1414556645.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC soc cleanups for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-cleanups-for-v3.19

for you to fetch changes up to dac95365dc2683df55c4e221e2f669a056863307:

  ARM: shmobile: sh73a0: Remove wrapper sh73a0_init_delay() (2014-10-24 13:07:01 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Soc Cleanups for v3.19

* Remove sh73a0_init_delay and r8a7778_init_delay wrappers

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7778: Remove wrapper r8a7778_init_delay()
      ARM: shmobile: sh73a0: Remove wrapper sh73a0_init_delay()

 arch/arm/mach-shmobile/r8a7778.h       | 1 -
 arch/arm/mach-shmobile/setup-r8a7778.c | 7 +------
 arch/arm/mach-shmobile/setup-sh73a0.c  | 9 ++-------
 arch/arm/mach-shmobile/sh73a0.h        | 1 -
 4 files changed, 3 insertions(+), 15 deletions(-)
