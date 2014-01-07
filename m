From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue,  7 Jan 2014 17:47:51 +0100
Subject: [PATCH 0/2] clk: shmobile rcar-gen2 fixes
Message-ID: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These two patches fix the clock parents and qspi clock divisor in the
rcar-gen2 clock driver.

Geert, could you please verify that the series fixes your QSPI clock issues
with the Koelsch board ?

Laurent Pinchart (2):
  clk: shmobile: rcar-gen2: Fix clock parent all non-PLL clocks
  clk: shmobile: rcar-gen2: Fix qspi divisor

 drivers/clk/shmobile/clk-rcar-gen2.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart
