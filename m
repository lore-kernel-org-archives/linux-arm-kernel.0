From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:46:05 +0100 (CET)
Subject: [RFC PATCH 23/33] irqchip/gic-v3-its: Add VPENDBASER/VPROPBASER
 accessors
In-Reply-To: <1484648454-21216-24-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-24-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131145440.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> V{PEND,PROP}BASER being 64bit registers, they need some ad-hoc
> accessors on 32bit, specially given that VPENDBASER contains
> a Valid bit, making the access a bit convoluted.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
