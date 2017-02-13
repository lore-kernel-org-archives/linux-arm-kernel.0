From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:48:33 +0100 (CET)
Subject: [RFC PATCH 25/33] irqchip/gic-v3-its: Add VPE invalidation
 hook
In-Reply-To: <1484648454-21216-26-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-26-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131148240.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> When a guest issues a INVALL command targetting a collection, it must
> be translated into a VINVALL for the VPE that has this collection.
> 
> This patch implements a hook that offers this functionallity to the
> hypervisor.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
