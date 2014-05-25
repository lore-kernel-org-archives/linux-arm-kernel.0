From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 25 May 2014 13:12:11 -0400
Subject: [PATCH v3 0/2] irqchip: Broadcom Set Top Box Level-2 interrupt
 controller
In-Reply-To: <1400892054-24457-1-git-send-email-f.fainelli@gmail.com>
References: <1400892054-24457-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20140525171211.GK8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:40:52PM -0700, Florian Fainelli wrote:
> Hi Thomas, Jason,
> 
> This patch set adds an irqchip driver for the Broadcom Set Top Box Level-2
> interrupt controller hardware, as well as a corresponding Device Tree binding
> document.
> 
> Thanks!
> 
> Florian Fainelli (2):
>   irqchip: add Broadcom Set Top Box Level-2 interrupt controller
>   Documentation: add Broadcom STB Level-2 interrupt controller binding
> 
>  .../bindings/interrupt-controller/brcm,l2-intc.txt |  29 +++
>  drivers/irqchip/Kconfig                            |   6 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-brcmstb-l2.c                   | 231 +++++++++++++++++++++
>  4 files changed, 267 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
>  create mode 100644 drivers/irqchip/irq-brcmstb-l2.c

Applied to irqchip/core

thx,

Jason.
