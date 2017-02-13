From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 12:19:55 +0100 (CET)
Subject: [RFC PATCH 00/33] irqchip: Core support for GICv4
In-Reply-To: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131218160.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> This series implements the core support for GICv4. And despite its
> size, it does exactly *nothing*. What it adds is an infrastructure
> that a hypervisor (KVM) can use to route VLPIs to a guest.

That's a very well done patch set and it was a pleasure to review!

Thanks,

	tglx
