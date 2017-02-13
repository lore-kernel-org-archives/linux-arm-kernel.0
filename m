From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:57:03 +0100 (CET)
Subject: [RFC PATCH 27/33] irqchip/gic-v3-its: Add VPE interrupt
 masking
In-Reply-To: <1484648454-21216-28-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-28-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131156530.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> When masking/unmasking a doorbell interrupt, it is necessary
> to issue an invalidation to the corresponding redistributor.
> We use the DirectLPI feature by writting directly to the corresponding
> redistributor.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
