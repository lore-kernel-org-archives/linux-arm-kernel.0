From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 12:16:43 +0100 (CET)
Subject: [RFC PATCH 30/33] irqchip/gic-v4: Add VPE command interface
In-Reply-To: <1484648454-21216-31-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-31-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131216360.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> Add the required interfaces to schedule a VPE and perform a
> VINVALL command.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
