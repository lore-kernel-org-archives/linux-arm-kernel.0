From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:32:47 +0100 (CET)
Subject: [RFC PATCH 14/33] irqchip/gic-v3-its: Generalize LPI configuration
In-Reply-To: <1484648454-21216-15-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131132360.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> We're are going to need to change a bit more than just the enable
> bit in the LPI property table in the future. So let's change the
> LPI configuration funtion to take a set of bits to be cleared,
> and a set of bits to be set.
> 
> This way, we'll be able to use it when a guest updates an LPI
> property (priority, for example).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
