From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 11 Dec 2013 16:47:13 +0800
Subject: [GIT PULL v2][for 3.14] pull request for hisilicon clock
Message-ID: <52A82691.5030207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Please help to pull request from hisilicon clock. It's used to replace 
the old request. The change is in below.

     1. Fix the git repository address link from ssh:// to git://.
     2. Append two patches to fix the wrong setting in hi3620 clock 
driver. All the fix are in the clock tables.

Best Regards
Haojian

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git 
tags/clk-hisilicon

for you to fetch changes up to ea010e5188dab61b64c1ad0221adc271039e7775:

   clk: hi3620: add gate clock flag (2013-12-11 16:42:23 +0800)

----------------------------------------------------------------
clk-hisilicon-for-3.14

----------------------------------------------------------------
Haojian Zhuang (3):
       clk: hisilicon: add common clock support
       clk: hi3620: fix wrong flags on divider
       clk: hi3620: add gate clock flag

  Documentation/devicetree/bindings/clock/hi3620-clock.txt |  19 +++++++
  drivers/clk/Makefile                                     |   1 +
  drivers/clk/hisilicon/Makefile                           |   5 ++
  drivers/clk/hisilicon/clk-hi3620.c                       | 242 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/clk/hisilicon/clk.c                              | 171 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/clk/hisilicon/clk.h                              | 103 
++++++++++++++++++++++++++++++++++++
  drivers/clk/hisilicon/clkgate-separated.c                | 130 
++++++++++++++++++++++++++++++++++++++++++++++
  include/dt-bindings/clock/hi3620-clock.h                 | 152 
+++++++++++++++++++++++++++++++++++++++++++++++++++++
  8 files changed, 823 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/clock/hi3620-clock.txt
  create mode 100644 drivers/clk/hisilicon/Makefile
  create mode 100644 drivers/clk/hisilicon/clk-hi3620.c
  create mode 100644 drivers/clk/hisilicon/clk.c
  create mode 100644 drivers/clk/hisilicon/clk.h
  create mode 100644 drivers/clk/hisilicon/clkgate-separated.c
  create mode 100644 include/dt-bindings/clock/hi3620-clock.h
