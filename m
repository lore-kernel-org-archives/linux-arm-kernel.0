From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:28:23 +0100 (CET)
Subject: [RFC PATCH 09/33] irqchip/gic-v3-its: Split out property table
 allocation
In-Reply-To: <1484648454-21216-10-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131128130.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> Move the LPI property table allocation into its own function, as
> this is going to be required for those associated with VMs in
> the future.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
