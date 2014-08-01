From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri,  1 Aug 2014 17:21:09 +0800
Subject: [PATCH v3 0/5] clk: hix5hd2: clocks update
Message-ID: <1406884874-30406-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3: 
Add patches 3, 4, 5 for clocks of watchdog, ir, and i2c
Patches 1, 2 are same as v2

Guoxiong Yan (2):
  clk: hix5hd2: add watchdog0 clocks
  clk: hix5hd2: add ir clocks

Jiancheng Xue (1):
  clk: hix5hd2: add sd clk

Wei Yan (1):
  clk: hix5hd2: add the I2C clocks

Zhangfei Gao (1):
  clk: hix5hd2: add complex clk

 drivers/clk/hisilicon/clk-hix5hd2.c       |  241 ++++++++++++++++++++++++++++-
 include/dt-bindings/clock/hix5hd2-clock.h |   29 ++++
 2 files changed, 264 insertions(+), 6 deletions(-)

-- 
1.7.9.5
