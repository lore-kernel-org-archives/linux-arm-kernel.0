From: stefan.kristiansson@saunalahti.fi (Stefan Kristiansson)
Date: Wed, 27 Aug 2014 20:09:06 +0300
Subject: [PATCH v2 21/26] irqchip: or1k-pic: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-22-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
 <1409047421-27649-22-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140827170905.GA5838@chokladfabriken.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:03:36AM +0100, Marc Zyngier wrote:
> Use the new handle_domain_irq method to handle interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

This (and the other two openrisc related patches in this series) works fine
in my setup at least.

Acked-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
