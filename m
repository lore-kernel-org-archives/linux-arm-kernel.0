From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 11 May 2011 17:48:04 +0200
Subject: [PATCH v5] sdio: optimized SDIO IRQ handling for single irq
Message-ID: <1305128885-21275-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize performance for single irq

Changes since v4.
 * Proper rebase on mmc-next. In previous patch, a spelling-patch in sdio_irq
   was accidentally rebased on top as well causing merge conflict.

Stefan Nilsson XK (1):
  sdio: optimized SDIO IRQ handling for single irq

 drivers/mmc/core/sdio_irq.c |   33 ++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 33 insertions(+), 1 deletions(-)

-- 
1.7.4.1
