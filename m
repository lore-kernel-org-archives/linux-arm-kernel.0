From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 4 May 2012 06:14:00 +0000
Subject: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
In-Reply-To: <20120503193732.GG5140@atomide.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
 <20120503155717.GE5140@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1348F@DBDE01.ent.ti.com>
 <20120503193732.GG5140@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1411F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 01:07:32, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120503 09:45]:
> > 
> > What about cpu_is_omap34xx() true for am33xx? Should we follow it?
> 
> Well are there components that could be used as is with that?
> If not, then it probably does not make sense.
> 

I am also in favor of not following cpu_is_omap34xx() for am33xx, but what about ARCH_OMAP?
I don't see that you are in agreement in creating ARCH_OMAPAM33XX. 
Does it make sense to say that, for am33xx, cpu_is_omap34xx() is false, but still it is under ARCH_OMAP3?


> BTW, you should post your patches on top of the clean-up patches
> Santosh posted as that already leaves out some cpu_is_omapxxxx
> checks. That's the "ARM: OMAP2+: Misc cleanup" thread.
> 

Ok. I will do that.

Thanks,
Vaibhav
