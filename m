From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 19 Jul 2011 15:00:12 +0530
Subject: [GIT PULL v2] DaVinci fixes for v3.0
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DBDC6EF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Can you please pull these DaVinci fixes for v3.0?

Thanks,
Sekhar

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:
  Linus Torvalds (1):
        Linux 3.0-rc7

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git fixes

Ido Yariv (1):
      arm: davinci: Fix low level gpio irq handlers' argument

Jon Povey (1):
      davinci: DM365 EVM: fix video input mux bits

Todd Poynor (1):
      ARM: davinci: Check for NULL return from irq_alloc_generic_chip

 arch/arm/mach-davinci/board-dm365-evm.c |    4 ++--
 arch/arm/mach-davinci/gpio.c            |   21 ++++++++++++++++-----
 arch/arm/mach-davinci/irq.c             |    6 ++++++
 3 files changed, 24 insertions(+), 7 deletions(-)
