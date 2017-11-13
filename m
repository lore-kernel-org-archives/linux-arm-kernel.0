From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 13 Nov 2017 19:23:46 +0530
Subject: [PATCH 0/3] irqchip:  pr_err() strings should end with newlines
Message-ID: <cover.1510580710.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Arvind Yadav (3):
  [PATCH 1/3] irqchip/mips-gic:  pr_err() strings should end with newlines
  [PATCH 2/3] irqchip/s3c24xx:  pr_err() strings should end with newlines
  [PATCH 3/3] irqchip/gic-v3:  pr_err() strings should end with newlines

 drivers/irqchip/irq-gic-v3.c   | 2 +-
 drivers/irqchip/irq-mips-gic.c | 4 ++--
 drivers/irqchip/irq-s3c24xx.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.9.1
