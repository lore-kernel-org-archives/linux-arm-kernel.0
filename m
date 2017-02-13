From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 10:55:04 +0100 (CET)
Subject: [RFC PATCH 04/33] irqchip/gic-v3-its: Move LPI definitions around
In-Reply-To: <1484648454-21216-5-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131054530.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> The various LPI definitions are in the middle of the code, and
> would be better placed at the beginning, given that we're going
> to use some of them much earlier.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
