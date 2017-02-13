From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:30:49 +0100 (CET)
Subject: [RFC PATCH 12/33] irqchip/gic-v3-its: Rework LPI freeing
In-Reply-To: <1484648454-21216-13-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-13-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131129200.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> Rework LPI deallocation so that it can be reused by the v4 support
> code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
