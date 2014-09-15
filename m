From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Sep 2014 08:31:46 -0700
Subject: [PATCH 00/35] arm: omap: move intc to drivers/irqchip/
In-Reply-To: <20140914051858.GF21986@titan.lakedaemon.net>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <20140914051858.GF21986@titan.lakedaemon.net>
Message-ID: <20140915153145.GC2762@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jason Cooper <jason@lakedaemon.net> [140913 22:19]:
> On Mon, Jul 28, 2014 at 04:15:48PM -0500, Felipe Balbi wrote:
> 
> For patches 32-35, please fix the subject line to:
> 
>   irqchip: omap-intc: C...
> 
> With that changed, patches 30-35 are:
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Great, thanks Jason for looking through them.

Felipe, can you please repost the missing patches with Jason's
changes and leaving out patch 30/35 to avoid board-*.c file
churn?

The branch to use for rebasing is omap-for-v3.18/intc-v2
that already contains the arch/arm/mach-omap2 related changes.

Regards,

Tony
