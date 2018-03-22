From: abel.vesa@nxp.com (Abel Vesa)
Date: Thu, 22 Mar 2018 11:55:25 +0200
Subject: [PATCH 0/4] arm: imx: Clock related updates
Message-ID: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of the imx upstreaming effort. All the changes are related imx
generic clk API and imx7d clk driver. The imx clk API updates will also be used
by the new imx SOCs that will follow.

Abel Vesa (1):
  arm: imx: Update clk driver API

Anson Huang (3):
  arm: imx: Correct dram pll type
  arm: imx: Correct ahb clk parent select
  arm: imx: Update clk driver for imx7d

 drivers/clk/imx/clk-imx7d.c | 127 +++++++++++++++++++++++---------------------
 drivers/clk/imx/clk.h       |  42 +++++++++++----
 2 files changed, 98 insertions(+), 71 deletions(-)

-- 
2.7.4
