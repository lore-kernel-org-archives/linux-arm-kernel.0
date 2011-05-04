From: per.forlin@linaro.org (Per Forlin)
Date: Wed,  4 May 2011 18:06:00 +0200
Subject: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
Message-ID: <1304525161-14448-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize performance for single irq

Changes since v1.
 * Add member to hold sdio_single_irq function in mmc_card and
   minimize new code in process_sdio_pending_irqs
 * Clarify commit message

Stefan Nilsson XK (1):
  sdio: optimized SDIO IRQ handling for single irq

 drivers/mmc/core/sdio_irq.c |   30 ++++++++++++++++++++++++++++++
 include/linux/mmc/card.h    |    1 +
 2 files changed, 31 insertions(+), 0 deletions(-)

-- 
1.7.4.1
