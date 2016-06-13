From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jun 2016 01:18:52 +0000
Subject: [PATCH] irqchip/bcm2836: make bcm2836_smp_boot_secondary static
In-Reply-To: <1465407697-8116-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465407697-8116-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160613011852.GI24391@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Ben,

On Wed, Jun 08, 2016 at 06:41:37PM +0100, Ben Dooks wrote:
> The bcm2836_smp_boot_secondary() is not declared or used elsewhere
> so make it static to fix the following warning:
> 
> drivers/irqchip/irq-bcm2836.c:227:12: warning: symbol 'bcm2836_smp_boot_secondary' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/irqchip/irq-bcm2836.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This, and the rest of the irqchip/ ones, applied to irqchip/misc.

thx,

Jason.
