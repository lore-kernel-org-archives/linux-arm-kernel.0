From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 May 2014 17:40:52 -0700
Subject: [PATCH v3 0/2] irqchip: Broadcom Set Top Box Level-2 interrupt
 controller
Message-ID: <1400892054-24457-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Jason,

This patch set adds an irqchip driver for the Broadcom Set Top Box Level-2
interrupt controller hardware, as well as a corresponding Device Tree binding
document.

Thanks!

Florian Fainelli (2):
  irqchip: add Broadcom Set Top Box Level-2 interrupt controller
  Documentation: add Broadcom STB Level-2 interrupt controller binding

 .../bindings/interrupt-controller/brcm,l2-intc.txt |  29 +++
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-brcmstb-l2.c                   | 231 +++++++++++++++++++++
 4 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
 create mode 100644 drivers/irqchip/irq-brcmstb-l2.c

-- 
1.9.1
