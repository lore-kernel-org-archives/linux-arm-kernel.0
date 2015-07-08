From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jul 2015 21:24:53 +0530
Subject: [PATCH] ARM: davinci: cp_intc: use IRQCHIP_SKIP_SET_WAKE instead
 of irq_set_wake callback
In-Reply-To: <1435941754-21102-1-git-send-email-sudeep.holla@arm.com>
References: <1435941754-21102-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <559D47CD.6090003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 July 2015 10:12 PM, Sudeep Holla wrote:
> Commit 60f96b41f71d ("genirq: Add IRQCHIP_SKIP_SET_WAKE flag")
> introduced a new flag to skip the irq_set_wake callback in the irqchip
> core to avoid adding dummy irq_set_wake in the irqchip implementations.
> 
> This patch removes the dummy callback and sets the IRQCHIP_SKIP_SET_WAKE
> flags.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

The patch looks good and I have queued in my testing branch for v4.3. I
have not been able to test it yet.

Thanks,
Sekhar
