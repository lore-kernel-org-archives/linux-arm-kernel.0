From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 11 May 2011 09:53:35 +0200
Subject: [PATCH v4] sdio: optimized SDIO IRQ handling for single irq
Message-ID: <1305100416-5395-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize performance for single irq

Changes since v2.
 * Rebase on mmc-next, change of line numbers no code changes.

Stefan Nilsson XK (1):
  sdio: optimized SDIO IRQ handling for single irq

 drivers/mmc/core/sdio_irq.c |   33 ++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 33 insertions(+), 1 deletions(-)

-- 
1.7.4.1
