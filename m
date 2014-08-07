From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu,  7 Aug 2014 09:35:57 +0800
Subject: [PATCH v4 0/4] clk: hix5hd2: clocks update
Message-ID: <1407375361-24958-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:
Drop ir clock, whose register is not in the same region

v3: 
Add patches 3, 4, 5 for clocks of watchdog, ir, and i2c
Patches 1, 2 are same as v2

Guoxiong Yan (1):
  clk: hix5hd2: add watchdog0 clocks

Jiancheng Xue (1):
  clk: hix5hd2: add sd clk

Wei Yan (1):
  clk: hix5hd2: add the I2C clocks

Zhangfei Gao (1):
  clk: hix5hd2: add complex clk

 drivers/clk/hisilicon/clk-hix5hd2.c       |  236 ++++++++++++++++++++++++++++-
 include/dt-bindings/clock/hix5hd2-clock.h |   27 ++++
 2 files changed, 257 insertions(+), 6 deletions(-)

-- 
1.7.9.5
