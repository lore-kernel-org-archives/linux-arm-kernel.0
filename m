From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:45:33 +0100 (CET)
Subject: [RFC PATCH 22/33] irqchip/gic-v3-its: Add VPE irq domain
 [de]activation
In-Reply-To: <1484648454-21216-23-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-23-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131145220.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> On activation, a VPE is mapped using the VMAPP command, followed
> by a VINVALL for a good measure. On deactivation, the VPE is
> simply unmapped.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
