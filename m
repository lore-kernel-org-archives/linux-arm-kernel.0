From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 10:39:14 +0100 (CET)
Subject: [RFC PATCH 01/33] irqchip/gic-v3: Add redistributor iterator
In-Reply-To: <1484648454-21216-2-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131039020.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> In order to discover the VLPI properties, we need to iterate over
> the redistributor regions. As we already have code that does this,
> let's factor it out and make it slightly more generic.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
