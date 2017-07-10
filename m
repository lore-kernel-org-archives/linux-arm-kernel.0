From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 10:53:15 -0500
Subject: [PATCH 6/6] irqchip: brcmstb-l2: Add support for the BCM7271 L2
 controller
In-Reply-To: <20170707192016.13001-7-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-7-opendmb@gmail.com>
Message-ID: <20170710155315.2sa6k3auolxpo2ns@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 12:20:16PM -0700, Doug Berger wrote:
> Add the initialization of the generic irq chip for the BCM7271 L2
> interrupt controller.  This controller only supports level
> interrupts and uses the "brcm,bcm7271-l2-intc" compatibility
> string.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  .../bindings/interrupt-controller/brcm,l2-intc.txt |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/irqchip/irq-brcmstb-l2.c                   | 86 ++++++++++++++++------
>  2 files changed, 66 insertions(+), 23 deletions(-)
