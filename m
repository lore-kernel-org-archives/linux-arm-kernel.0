From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 30 Jul 2018 09:36:06 +0100
Subject: [PATCH v2 0/2] Add functions to get optional clocks
Message-ID: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few drivers get an optional clock, e.g. a clock required
to access peripheral's registers that is always enabled on some
devices.

Phil Edworthy (2):
  clk: Add of_clk_get_by_name_optional() function
  clk: Add functions to get optional clocks

 drivers/clk/clk-devres.c | 18 ++++++++++++++++--
 drivers/clk/clkdev.c     | 49 +++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/clk.h      | 30 +++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.7.4
