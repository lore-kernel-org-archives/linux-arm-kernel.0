From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 12:16:23 +0100 (CET)
Subject: [RFC PATCH 29/33] irqchip/gic-v4: Add per-VM VPE domain creation
In-Reply-To: <1484648454-21216-30-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-30-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131216100.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> When creating a VM, it is very convenient to have an irq domain
> containing all the doorbell interrupts associated with that VM
> (each interrupt representing a VPE).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
