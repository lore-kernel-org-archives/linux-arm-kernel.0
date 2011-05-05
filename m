From: per.forlin@linaro.org (Per Forlin)
Date: Thu,  5 May 2011 21:14:02 +0200
Subject: [PATCH v3] sdio: optimized SDIO IRQ handling for single irq
Message-ID: <1304622843-5123-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize performance for single irq

Changes since v2.
 * Clarify comment in process_sdio_pending_irqs
 * Simplify sdio_single_irq if-condition

Stefan Nilsson XK (1):
  sdio: optimized SDIO IRQ handling for single irq

 drivers/mmc/core/sdio_irq.c |   33 ++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 33 insertions(+), 1 deletions(-)

-- 
1.7.4.1
