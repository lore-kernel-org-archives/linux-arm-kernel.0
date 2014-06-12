From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 12 Jun 2014 10:39:27 +0800
Subject: [PATCH v2 0/2] clk: clk-hix5hd2 add complex clk and sd clk
Message-ID: <1402540769-6156-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix usb clk typo

Jiancheng Xue (1):
  clk: hix5hd2: add sd clk

Zhangfei Gao (1):
  clk: hix5hd2: add complex clk

 drivers/clk/hisilicon/clk-hix5hd2.c       |  205 ++++++++++++++++++++++++++++-
 include/dt-bindings/clock/hix5hd2-clock.h |   13 ++
 2 files changed, 212 insertions(+), 6 deletions(-)

-- 
1.7.9.5
