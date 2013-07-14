From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 13 Jul 2013 23:39:33 -0600
Subject: [PATCH] irqchip: bcm2835: Convert to use IRQCHIP_DECLARE macro
In-Reply-To: <1372955496.9018.2.camel@phoenix>
References: <1372955496.9018.2.camel@phoenix>
Message-ID: <51E23995.4040606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2013 10:31 AM, Axel Lin wrote:
> This patch converts irq-bcm2835 driver to use the new IRQCHIP_DECLARE and
> irqchip_init.

I guess the diffs to the ARM tree are much smaller than the irqchip
tree, so it's simplest to take it through the irqchip tree, so,

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Tested-by: Stephen Warren <swarren@wwwdotorg.org>
