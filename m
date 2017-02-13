From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 10:39:28 +0100 (CET)
Subject: [RFC PATCH 02/33] irqchip/gic-v3: Add VLPI/DirectLPI discovery
In-Reply-To: <1484648454-21216-3-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131039170.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> Add helper functions that probe for VLPI and DirectLPI properties.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
