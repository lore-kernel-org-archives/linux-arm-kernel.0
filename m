From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:55:08 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Cleanups for v3.19
Message-ID: <cover.1416530979.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC cleanups for v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-cleanups-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit dac95365dc2683df55c4e221e2f669a056863307:

  ARM: shmobile: sh73a0: Remove wrapper sh73a0_init_delay() (2014-10-24 13:07:01 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-cleanups2-for-v3.19

for you to fetch changes up to 3e940958ed3625187704f41129801800f70c2169:

  ARM: shmobile: r8a7779: Spelling/grammar s/entity/identity/, s/map/mapping/ (2014-11-17 10:35:07 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Cleanups for v3.19

* Spelling and grammar fixes

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: sh73a0: Spelling/grammar s/entity map/identity mapping/
      ARM: shmobile: sh7372: Spelling/grammar s/entity map/identity mapping/
      ARM: shmobile: r8a7779: Spelling/grammar s/entity/identity/, s/map/mapping/

 arch/arm/mach-shmobile/setup-r8a7779.c | 6 +++---
 arch/arm/mach-shmobile/setup-sh7372.c  | 2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
