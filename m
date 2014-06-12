From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Jun 2014 06:57:15 -0700
Subject: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from getting
 mapped to crossbar
In-Reply-To: <20140612125134.GS8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
 <20140612125134.GS8664@titan.lakedaemon.net>
Message-ID: <20140612135715.GE17845@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jason Cooper <jason@lakedaemon.net> [140612 05:52]:
> On Thu, Jun 12, 2014 at 05:23:11PM +0530, Sricharan R wrote:
> > From: Nishanth Menon <nm@ti.com>
> > 
> > When, in the system due to varied reasons, interrupts might be unusable
> > due to hardware behavior, but register maps do exist, then those interrupts
> > should be skipped while mapping irq to crossbars.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Tony, have you applied these somewhere already?

I think some of these I had applied into a branch ready for
merging but then it was discovered that further changes
were needed and the branch was dropped.

Sricharan, please remove my Signed-off-by from this series.
If I end up applying it for merging my scripts will add it
automatically.

Regards,

Tony
