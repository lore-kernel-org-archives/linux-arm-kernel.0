From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 10 Jun 2013 16:05:05 +0100
Subject: [PATCH 0/2] clk vexpress updates for 3.11
Message-ID: <1370876707-25265-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Could you please queue these two small updates of the vexpress clk
drivers?

Thanks!

Pawel

Pawel Moll (2):
  clk: vexpress: Use full node name to identify individual clocks
  clk: vexpress: Make the clock drivers directly available for arm64

 drivers/clk/Kconfig                      | 2 +-
 drivers/clk/versatile/clk-vexpress-osc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.1.2
