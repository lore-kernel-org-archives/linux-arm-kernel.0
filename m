From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 May 2012 11:17:01 +0800
Subject: [GIT PULL][for 3.4]pull request for fix branch in arch-pxa
Message-ID: <CAN1soZwOhZBCaY8K_mj-uwxc1aA54JiOvRkxA9X7BMdViU3nVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to merge this fixes branch from arch-pxa git tree.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git fixes

Haojian Zhuang (2):
      mfd: max8925: request resource region
      ARM: mmp: add io head file

 arch/arm/Kconfig                    |    1 +
 arch/arm/mach-mmp/include/mach/io.h |   13 +++++++++++++
 drivers/mfd/max8925-core.c          |    4 ++++
 3 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/io.h
