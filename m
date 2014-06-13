From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Jun 2014 09:41:21 -0400
Subject: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from
 getting mapped to crossbar
In-Reply-To: <539AFE18.3020706@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
 <20140612125134.GS8664@titan.lakedaemon.net>
 <20140612135715.GE17845@atomide.com>
 <20140612140508.GC8664@titan.lakedaemon.net>
 <539AA08A.7010001@ti.com>
 <20140613131005.GF8664@titan.lakedaemon.net>
 <539AFE18.3020706@ti.com>
Message-ID: <20140613134121.GL8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 09:35:20AM -0400, Santosh Shilimkar wrote:
> On Friday 13 June 2014 09:10 AM, Jason Cooper wrote:
...
> > Have you tried booting all the different scenarios?  eg:
> > 
> >   old dtb, new driver
> >   new dtb, old driver
> >   old dtb, old driver
> >   new dtb, new driver
> > 
> Old driver wasn't complete as mentioned and hence the above
> combinations becomes bit irrelevant.

Ahh, great!  In that case, I think we should be good without the
dependency between the code changes and the dtsi changes.

thx,

Jason.
