From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 8 Jun 2011 15:21:29 +0530
Subject: [GIT PULL] DaVinci fixes for v3.0-rc
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D384091@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Can you please pull these two changes for v3.0-rc release?

Thomas's patch fixes a regression because of generic irq chip
support for DaVinci introduced in v3.0-rc1. My patch is not
a regression fix but fixes an issue that has been existing for
a while.

Thanks,
Sekhar

The following changes since commit 59c5f46fbe01a00eedf54a23789634438bb80603:
  Linus Torvalds (1):
        Linux 3.0-rc2

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git davinci-next

Sekhar Nori (1):
      davinci: make PCM platform devices static

Thomas Gleixner (1):
      arm: davinci: Fix fallout from generic irq chip conversion

 arch/arm/mach-davinci/devices-da8xx.c |    2 +-
 arch/arm/mach-davinci/devices.c       |    2 +-
 arch/arm/mach-davinci/gpio.c          |    7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)
