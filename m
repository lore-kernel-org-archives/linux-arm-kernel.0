From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 30 Jul 2018 14:31:47 +0100
Subject: [PATCH v3 0/2] clk: Add functions to get optional clocks
Message-ID: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few drivers get an optional clock, e.g. a bus clock required to 
access peripheral's registers that is always enabled on some devices.

Phil Edworthy (2):
  clk: Add of_clk_get_by_name_optional() function
  clk: Add functions to get optional clocks

 drivers/clk/clk-devres.c | 18 +++++++++++++++--
 drivers/clk/clkdev.c     | 51 +++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/clk.h      | 35 +++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 7 deletions(-)

-- 
2.7.4
