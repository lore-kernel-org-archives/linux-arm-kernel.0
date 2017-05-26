From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 26 May 2017 15:38:18 +0800
Subject: [PATCH v2 0/3] clk: hi3660: add more clocks and fix bugs
Message-ID: <20170526073821.25971-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds more clocks for hi3660, video encoder/decoder, ISP. It
includes also bug fixes.

v2 update:
 - added ISP clocks into patch 2.

Chen Jun (2):
  clk: hi3660: fix wrong parent name of clk_mux_sysbus
  clk: hi3660: add clocks for video encoder, decoder and ISP

Zhong Kaihua (1):
  clk: hi3660: Set PPLL2 to 2880M

 drivers/clk/hisilicon/clk-hi3660.c       | 50 +++++++++++++++++++++++++++++---
 include/dt-bindings/clock/hi3660-clock.h | 17 +++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)

-- 
2.10.2
