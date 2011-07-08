From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 8 Jul 2011 14:36:03 +0530
Subject: [GIT PULL] DaVinci cleanups for v3.1
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D9B56D3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following DaVinci clean-ups for the v3.1 merge window.
The patch "davinci: dm6467/T EVM: fix setting up of reference clock rate"
ends up adding extra code, but should make adding new boards with
different reference clock rate very simple.

There are further clean-ups pending merge of SRAM consolidation patch
by Russell. If I see that getting merged, I can send a follow-up pull
request. There is also another patch for which I am awaiting Mauro's ack.

Thanks,
Sekhar

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
  Linus Torvalds (1):
        Linux 3.0-rc6

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git cleanup

Sekhar Nori (2):
      davinci: psc.h: clean up indentation done using spaces
      davinci: dm6467/T EVM: fix setting up of reference clock rate

 arch/arm/mach-davinci/board-dm646x-evm.c    |   17 +--
 arch/arm/mach-davinci/clock.c               |   38 +++++++
 arch/arm/mach-davinci/clock.h               |    2 +
 arch/arm/mach-davinci/dm646x.c              |    4 +-
 arch/arm/mach-davinci/include/mach/dm646x.h |    2 -
 arch/arm/mach-davinci/include/mach/psc.h    |  148 +++++++++++++-------------
 6 files changed, 123 insertions(+), 88 deletions(-)
