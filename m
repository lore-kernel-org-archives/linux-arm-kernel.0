From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 7 Mar 2012 09:54:20 +0800
Subject: [GIT PULL v2][for v3.4] request pull from arch-pxa on regulator branch
Message-ID: <CAN1soZzw+hAACoscyJ0q65t84ighZ1zPG92uKnwT-pDgcF2b6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please help to merge these patches from arch-pxa. They're used to
convert bq24022
to gpio-regulator. Now Mark acked these patches.

Best Regards
Haojian

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git regulator

Heiko St?bner (2):
      pxa: magician/hx4700: Convert to gpio-regulator from bq24022
      regulator: Remove bq24022 regulator driver

 arch/arm/configs/magician_defconfig |    2 +-
 arch/arm/mach-pxa/hx4700.c          |   33 ++++++--
 arch/arm/mach-pxa/magician.c        |   33 ++++++--
 drivers/regulator/Kconfig           |    8 --
 drivers/regulator/Makefile          |    1 -
 drivers/regulator/bq24022.c         |  162 -----------------------------------
 include/linux/regulator/bq24022.h   |   24 -----
 7 files changed, 55 insertions(+), 208 deletions(-)
 delete mode 100644 drivers/regulator/bq24022.c
 delete mode 100644 include/linux/regulator/bq24022.h
