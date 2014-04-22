From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Apr 2014 19:46:51 +0800
Subject: [PATCH 0/3] add hisilicon clk-hix5hd2
Message-ID: <1398167214-1604-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zhangfei Gao (3):
  clk: hisi: use clk_register_mux_table in hisi_clk_register_mux
  clk: hisi: add hisi_clk_register_gate
  clk: hisi: add clk-hix5hd2.c

 .../devicetree/bindings/clock/hix5hd2-clock.txt    |   31 ++++++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/hisilicon/Makefile                     |    1 +
 drivers/clk/hisilicon/clk-hix5hd2.c                |  101 ++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        |   41 +++++++-
 drivers/clk/hisilicon/clk.h                        |    3 +
 include/dt-bindings/clock/hix5hd2-clock.h          |   58 +++++++++++
 7 files changed, 231 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-hix5hd2.c
 create mode 100644 include/dt-bindings/clock/hix5hd2-clock.h

-- 
1.7.9.5
