From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 05:14:25 -0700
Subject: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
In-Reply-To: <1406582183-696-30-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-30-git-send-email-balbi@ti.com>
Message-ID: <20140729121425.GR29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140728 14:19]:
> now that we don't need to support legacy board-files,
> we can completely switch over to a linear irq domain
> and make use of irq_alloc_domain_generic_chips() to
> allocate all generic irq chips for us.

This patch seems to somehow break off-idle for omap3 
where it no longer wakes up.

Other than that, this whole series boots fine for me.

Regards,

Tony
