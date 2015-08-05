From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 11:34:57 +0200
Subject: [PATCH] ARM: davinci: cp_intc: use IRQCHIP_SKIP_SET_WAKE instead
 of irq_set_wake callback
In-Reply-To: <1438443236-30206-1-git-send-email-nsekhar@ti.com>
References: <1435941754-21102-1-git-send-email-sudeep.holla@arm.com>
 <1438443236-30206-1-git-send-email-nsekhar@ti.com>
Message-ID: <20150805093457.GO6390@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 01, 2015 at 09:03:56PM +0530, Sekhar Nori wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
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
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> ARM-SoC, can you please apply this patch directly?
> I do not have any other patches queued, so not sending
> a pull request.

Merged, thanks.


-Olof
