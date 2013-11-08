From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri,  8 Nov 2013 12:15:54 +0530
Subject: [PATCH 0/2] DaVinci: GPIO: fixes
Message-ID: <1383893156-28010-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

This patch series fixes gpio driver regestration
and offset check for unbanked gpio.

Lad, Prabhakar (2):
  gpio: davinci: Fix a check for unbanked gpio
  ARM: davinci: Fix number of resources passed to
    davinci_gpio_register() call

 arch/arm/mach-davinci/dm355.c  |    2 +-
 arch/arm/mach-davinci/dm365.c  |    2 +-
 arch/arm/mach-davinci/dm644x.c |    2 +-
 arch/arm/mach-davinci/dm646x.c |    2 +-
 drivers/gpio/gpio-davinci.c    |    4 +++-
 5 files changed, 7 insertions(+), 5 deletions(-)

-- 
1.7.9.5
