From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 23 Nov 2011 16:39:26 +0100
Subject: [PATCH] ARM: vic: register the VIC for ST-modified VIC's
In-Reply-To: <1322062110-24084-1-git-send-email-jamie@jamieiles.com>
References: <1322062110-24084-1-git-send-email-jamie@jamieiles.com>
Message-ID: <4ECD13AE.6060409@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2011 04:28 PM, Jamie Iles wrote:
> When probing the VIC, the ST variant has a different probing method to
> account for the extra interrupts which meant we didn't previously call
> vic_register() which registered the irq_domain.
>
> Cc: Linus Walleij<linus.walleij@stericsson.com>
> Cc: Russell King<rmk+linux@arm.linux.org.uk>
> Cc: Marc Zyngier<marc.zyngier@arm.com>
> Signed-off-by: Jamie Iles<jamie@jamieiles.com>
> ---
>
> I _think_ it's just Nomadik affected here which I don't have access to.
> I can send an updated pull request or put it in Russell's tracker,
> whichever is easiest.
>    

This also affects mach-u300 and mach-ep93xx OTOH.

This seems to be based on something else that is out-of-tree
so I don't get the whole picture...

Linus Walleij
