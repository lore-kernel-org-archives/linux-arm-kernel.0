From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 00:05:02 +0900
Subject: [GIT PULL 3/7] Samsung gpio for v3.8
Message-ID: <50AB9C1E.7040907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is for Samsung gpio stuff and got the ack from Linus Walleij.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/gpio-samsung

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

   Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/gpio-samsung

Eunki Kim (2):
       ARM: SAMSUNG: Insert bitmap_gpio_int member in samsung_gpio_chip
       gpio: samsung: Fix input mode setting function for GPIO int

Jingoo Han (1):
       gpio: samsung: use pr_* instead of printk

  arch/arm/plat-samsung/include/plat/gpio-core.h |    2 +
  arch/arm/plat-samsung/s5p-irq-gpioint.c        |    8 +++++-
  drivers/gpio/gpio-samsung.c                    |   25 
+++++++++++------------
  3 files changed, 20 insertions(+), 15 deletions(-)
