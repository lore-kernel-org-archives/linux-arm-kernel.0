From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 10 Jul 2015 22:57:53 -0600
Subject: [PATCH 3/4] irqchip: Add documentation for the bcm2836 interrupt
 controller.
In-Reply-To: <1436303617-17185-4-git-send-email-eric@anholt.net>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
 <1436303617-17185-4-git-send-email-eric@anholt.net>
Message-ID: <55A0A251.1010301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2015 03:13 PM, Eric Anholt wrote:
> This is a new per-cpu root interrupt controller on the Raspberry Pi 2,
> which will chain to the bcm2835 interrupt controller for peripheral
> interrupts.

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt

> +local_intc: local_intc {

> +	interrupt-parent = <&local_intc>;

I think that property shouldn't be there?
