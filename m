From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 31 Aug 2018 15:07:21 +0100
Subject: [PATCH v5 0/2] clk: Add functions to get optional clocks
Message-ID: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few drivers get an optional clock, e.g. a bus clock required to 
access peripheral's registers that is always enabled on some devices.

Phil Edworthy (2):
  clk: Add of_clk_get_by_name_optional() function
  clk: Add functions to get optional clocks

 drivers/clk/clk-devres.c | 18 ++++++++++--
 drivers/clk/clkdev.c     | 74 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/clk.h      | 35 +++++++++++++++++++++++
 3 files changed, 110 insertions(+), 17 deletions(-)

-- 
2.7.4
