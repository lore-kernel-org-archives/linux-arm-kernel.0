From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 24 Nov 2011 10:59:19 +0000
Subject: [PATCH] ARM: vic: register the VIC for ST-modified VIC's
In-Reply-To: <1322062110-24084-1-git-send-email-jamie@jamieiles.com>
References: <1322062110-24084-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20111124105919.GC5048@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 03:28:30PM +0000, Jamie Iles wrote:
> When probing the VIC, the ST variant has a different probing method to
> account for the extra interrupts which meant we didn't previously call
> vic_register() which registered the irq_domain.
> 
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Russell King <rmk+linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
> 
> I _think_ it's just Nomadik affected here which I don't have access to.
> I can send an updated pull request or put it in Russell's tracker,
> whichever is easiest.

Russell, would this be best in your patch tracker?  I've just tried a 
test merge of the irqchip consolidation branch into your devel branch 
and got some conflicts that I think you've already fixed up once.  The 
patch applies cleanly to your current devel branch.

Jamie
