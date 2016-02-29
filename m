From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 14:20:14 +0000
Subject: [PATCH 0/2] clk: bcm2835 expose current settings and registers
Message-ID: <1456755616-2472-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Expose the raw clock registers and also the current clock settings
(divider, parent, mash divider) via debugfs.

Martin Sperl (2):
  clk: bcm2835: expose raw clock-registers via debugfs
  clk: bcm2835: expose current divider, parent and mash via debugfs

 drivers/clk/bcm/clk-bcm2835.c |  211 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)

--
1.7.10.4
