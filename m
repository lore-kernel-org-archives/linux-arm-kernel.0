From: tali.perry1@gmail.com (Tali Perry)
Date: Thu, 15 Feb 2018 15:30:53 +0200
Subject: [PATCH v2 0/1] clk: npcm: add NPCM7xx clock driver
Message-ID: <1518701454-22697-1-git-send-email-tali.perry1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Nuvoton BMC NPCM7xx clock driver.

Nuvoton BMC NPCM7xx contain integrated clock controller which
generates and supplies clock to all modules within the NPCM7xx BMC

1 ==> 2
This patch includes fix request described here:
https://patchwork.kernel.org/patch/10200033/
(move fixed clocks to DT)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

Tali Perry (1):
  clk: npcm7xx: add clock controller. fixed clock at DT

 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm7xx.c | 759 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 760 insertions(+)
 create mode 100644 drivers/clk/clk-npcm7xx.c

-- 
2.14.1
