From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 11:33:01 +0200
Subject: AT91: Convert to fasteoi IRQ handler, and remove ARM irq_finish
In-Reply-To: <1303909742.18407.12.camel@redbox>
References: <1303909742.18407.12.camel@redbox>
Message-ID: <20110428093301.GB31786@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:09 Wed 27 Apr     , Andrew Victor wrote:
> The AT91's AIC interrupt controller will internally mask the current
> (and lower-priority) interrupts until software acknowledges that the
> interrupt was handled by writing to the AIC_EOICR register.
> 
> This matches the "fasteoi" IRQ flow-handler, so convert the AT91 to use
> handle_fasteoi_irq rather than handle_level_irq.
> 
> This also allows the irq_finish() call to be removed from the low-level
> ARM IRQ handler.
> 
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Good for me

I put it in the next or you take Thomas?

Best Regards,
J.
