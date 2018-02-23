From: radoslaw.pietrzyk@gmail.com (Radoslaw Pietrzyk)
Date: Fri, 23 Feb 2018 09:31:43 +0100
Subject: [PATCH v2 0/2] v2 patches for stm32-exti irq hierarchy
In-Reply-To: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
Message-ID: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Radoslaw Pietrzyk (2):
  irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
  pinctrl: stm32: Optimizes and enhances stm32gpio irqchip

 drivers/irqchip/irq-stm32-exti.c      | 13 -------------
 drivers/pinctrl/stm32/pinctrl-stm32.c |  3 ++-
 2 files changed, 2 insertions(+), 14 deletions(-)

-- 
1.9.1
