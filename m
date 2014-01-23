From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 11:37:56 +0100
Subject: [PATCH v2 0/2] at91: gpio: pinctrl: use gpiolib API to mark a GPIO
 used as an IRQ
Message-ID: <1390473478-5591-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change since V1:
* fixed unmasking/masking issue (unmask the irq in startup, mask it in shutdown)

Jean-Jacques Hiblot (2):
  at91: gpio: use gpiolib API to mark a GPIO used as an IRQ
  at91: pinctrl: use gpiolib API to mark a GPIO used as an IRQ

 arch/arm/mach-at91/gpio.c      | 27 +++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-at91.c | 27 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

-- 
1.8.5.2
