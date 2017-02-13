From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:56:42 +0100 (CET)
Subject: [RFC PATCH 26/33] irqchip/gic-v3-its: Add VPE affinity changes
In-Reply-To: <1484648454-21216-27-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-27-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131156260.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> When we're about to run a vcpu, it is crucial that the redistributor
> associated with the physical CPU is being told about the new residency.
> 
> This is abstracted by hijacking the irq_set_affinity method for the
> doorbell interrupt associated with the VPE. It is expected that the
> hypervisor will call this method before scheduling the VPE.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
