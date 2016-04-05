From: eric@anholt.net (Eric Anholt)
Date: Mon,  4 Apr 2016 20:44:14 -0700
Subject: [PATCH 0/4] irqchip: bcm2835: arm64 port
Message-ID: <1459827858-3871-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the series for irqchip-bcm283x on arm64 for the Pi3.  Since I'd
like to land Makefile changes that would enable building
irqchip-bcm283x on arm64, it would be nice if I had either a stable
branch to merge from, or an ack to merge them through the arm64 tree.

Eric Anholt (4):
  irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ
  irqchip: bcm2836: Drop smp_set_ops on arm64 builds
  irqchip: bcm2836: Fix compiler warning on 64-bit build
  irqchip: bcm2836: Use a more generic memory barrier call

 drivers/irqchip/irq-bcm2835.c |  3 +--
 drivers/irqchip/irq-bcm2836.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.7.0
