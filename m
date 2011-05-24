From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 24 May 2011 15:51:53 +0530
Subject: [GIT PULL] Pull request for 2.6.40
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D09B89A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I have been tracking these four patches for inclusion in 2.6.40
can you please pull them?

These are clean-up rather than consolidation patches and all
of them have zero or negative net diffstat.

Thanks,
Sekhar

The following changes since commit 0ee5623f9a6e52df90a78bd21179f8ab370e102e:
  Linus Torvalds (1):
        Linux 2.6.39-rc6

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git davinci-next

Manjunath Hadli (1):
      davinci: move DM64XX_VDD3P3V_PWDN to devices.c

Sergei Shtylyov (3):
      DA8xx: kill duplicate #define DA8XX_GPIO_BASE
      DA8xx: kill duplicate #define DA8XX_PLL1_BASE
      DA8xx: move base address #define's to their proper place

 arch/arm/mach-davinci/da850.c                 |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c         |   16 +++++++++-------
 arch/arm/mach-davinci/devices.c               |    3 +++
 arch/arm/mach-davinci/include/mach/da8xx.h    |    4 ----
 arch/arm/mach-davinci/include/mach/hardware.h |    3 ---
 5 files changed, 13 insertions(+), 15 deletions(-)
