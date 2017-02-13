From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:28:51 +0100 (CET)
Subject: [RFC PATCH 10/33] irqchip/gic-v4-its: Allow use of indirect VCPU
 tables
In-Reply-To: <1484648454-21216-11-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131128400.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> The VCPU tables can be quite sparse as well, and it makes sense
> to use indirect tables as well if possible.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
