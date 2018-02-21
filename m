From: radoslaw.pietrzyk@gmail.com (Radoslaw Pietrzyk)
Date: Wed, 21 Feb 2018 14:50:25 +0100
Subject: [PATCH 0/2] Optimizes, cleans up and enhances stm32-exti irq hierarchy
Message-ID: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- optimizes and cleans up stm32-exti irq domain
- optimizes and enhances stm32gpio irq chip

Radoslaw Pietrzyk (2):
  ARM: irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
  ARM: pinctrl: stm32: Optimizes and enhances stm32gpio irqchip

 drivers/irqchip/irq-stm32-exti.c      | 10 +---------
 drivers/pinctrl/stm32/pinctrl-stm32.c |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

-- 
1.9.1
