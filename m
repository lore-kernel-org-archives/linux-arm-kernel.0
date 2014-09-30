From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 30 Sep 2014 23:50:43 +0200 (CEST)
Subject: [PATCH 1/3] irqchip: dw-apb-ictl: always use use
 {readl|writel}_relaxed
In-Reply-To: <542AA157.8080908@gmail.com>
References: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
 <1411454100-6814-2-git-send-email-jszhang@marvell.com>
 <542AA157.8080908@gmail.com>
Message-ID: <alpine.DEB.2.11.1409302350080.4455@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Sep 2014, Sebastian Hesselbarth wrote:

> On 09/23/2014 08:34 AM, Jisheng Zhang wrote:
> > relaxed version and non-relaxed version are mixed, this patch always
> > use the relaxed version to unify the memory access usage.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> 
> While I don't agree with the above reason (unification) for this

Then we want a proper changelog for it, really.

Thanks,

	tglx
