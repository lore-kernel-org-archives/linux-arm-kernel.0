From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 12 Jun 2014 18:19:19 +0800
Subject: [PATCH] ARM: dts: berlin2q.dtsi: set L2CC tag and data latency
 as 2 cycles
In-Reply-To: <20140612181503.06562a38@xhacker>
References: <1402565920-5636-1-git-send-email-jszhang@marvell.com>
 <20140612094423.GC23430@n2100.arm.linux.org.uk>
 <20140612181503.06562a38@xhacker>
Message-ID: <20140612181919.038012f5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, 12 Jun 2014 03:15:03 -0700
Jisheng Zhang <jszhang@marvell.com> wrote:

> Hi Russell,
> 
> On Thu, 12 Jun 2014 02:44:23 -0700
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Thu, Jun 12, 2014 at 05:38:40PM +0800, Jisheng Zhang wrote:
> > > For all BG2Q SoCs, 2 cycles is the best/correct value
> > 
> > It would be a good idea to set all these parameters if you need to set
> > them at all - in other words, setting arm,dirty-latency as well, as
> > that's all part of the timing specification.
> > 
> 
> Thanks for reviewing this patch. I will check with SoC people to find the
> correct dirty-latency value.

The BG2Q L2 cache controller is PL310, so no "dirty-latency"

Thanks,
Jisheng
