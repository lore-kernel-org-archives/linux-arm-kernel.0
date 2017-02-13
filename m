From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:31:56 +0100 (CET)
Subject: [RFC PATCH 13/33] irqchip/gic-v3-its: Generalize device table
 allocation
In-Reply-To: <1484648454-21216-14-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131131470.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> As we want to use 2-level tables for VCPUs, let's hack the device
> table allocator in order to make it slightly more generic. It
> will get reused in subsequent patches.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
