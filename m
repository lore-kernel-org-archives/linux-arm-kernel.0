From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:28:00 +0100 (CET)
Subject: [RFC PATCH 08/33] irqchip/gic-v3-its: Implement
 irq_set_irqchip_state for pending state
In-Reply-To: <1484648454-21216-9-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131127450.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> Allow the pending state of an LPI to be set or cleared via
> irq_set_irqchip_state.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
