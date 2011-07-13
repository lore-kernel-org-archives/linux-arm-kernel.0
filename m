From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 13 Jul 2011 10:59:47 +0530
Subject: [GIT PULL] DaVinci fix for v3.0
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DA7B3D7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Can you please pull this late breaking DaVinci fix for v3.0?
This is fallout of generic irq chip migration and prevents GPIO
interrupts from functioning correctly.

Thanks,
Sekhar

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:
  Linus Torvalds (1):
        Linux 3.0-rc7

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git fixes

Ido Yariv (1):
      arm: davinci: Fix low level gpio irq handlers' argument

 arch/arm/mach-davinci/gpio.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)
