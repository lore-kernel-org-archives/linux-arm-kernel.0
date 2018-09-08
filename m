From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 8 Sep 2018 14:15:09 +0200 (CEST)
Subject: [PATCH] irqchip: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-24-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-24-robh@kernel.org>
Message-ID: <alpine.DEB.2.21.1809081414150.1402@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Aug 2018, Rob Herring wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Should I take it or do you want to take it with others? If the latter,
acked-by-me.

Thanks,

	tglx
