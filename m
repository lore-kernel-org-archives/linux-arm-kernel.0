From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 12 May 2014 11:53:04 +0800
Subject: [GIT PULL][for 3.16] pull request for clk-hisi
Message-ID: <CAD6h2NTBdtEUEvcG9ZrquacRUjc3LAOiOQdR+09MGk=9w48GDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Please help to pull clk-hisi-for-v3.16 branch for the next release.

Regards
Haojian

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
tags/clk-hisi-for-v3.16

for you to fetch changes up to 5efaf09021a5817e5a274aa2d2fad8d92d12ed92:

  clk: hisi: add clk-hix5hd2.c (2014-05-12 11:30:32 +0800)

----------------------------------------------------------------
enable hix5hd2 clock

----------------------------------------------------------------
Zhangfei Gao (3):
      clk: hisi: use clk_register_mux_table in hisi_clk_register_mux
      clk: hisi: add hisi_clk_register_gate
      clk: hisi: add clk-hix5hd2.c

 Documentation/devicetree/bindings/clock/hix5hd2-clock.txt |  31
+++++++++++++++++++
 drivers/clk/Makefile                                      |   1 +
 drivers/clk/hisilicon/Makefile                            |   1 +
 drivers/clk/hisilicon/clk-hix5hd2.c                       | 101
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                               |  41
+++++++++++++++++++++---
 drivers/clk/hisilicon/clk.h                               |   3 ++
 include/dt-bindings/clock/hix5hd2-clock.h                 |  58
++++++++++++++++++++++++++++++++++
 7 files changed, 231 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-hix5hd2.c
 create mode 100644 include/dt-bindings/clock/hix5hd2-clock.h
