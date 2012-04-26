From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 26 Apr 2012 18:49:12 +0000
Subject: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
In-Reply-To: <20120426184312.GY3739@atomide.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <20120418231837.GT21106@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 00:13:13, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120423 11:31]:
> > On Thu, Apr 19, 2012 at 04:48:37, Tony Lindgren wrote:
> > > * Hiremath, Vaibhav <hvaibhav@ti.com> [120413 03:39]:
> > > > On Thu, Apr 12, 2012 at 13:56:06, Paul Walmsley wrote:
> > > > 
> > > > Yes, we are using am3517evm file for AM33XX MACHINE_INIT definition here.
> > > > These patches have been reviewed and accepted in the list, only thing is
> > > > they couldn't make it to upstream during v3.4 merge window.
> > > > 
> > > > I believe Tony is going to push them for v3.5 now.
> > > 
> > > Hmm care to clarify which patches are you talking about here?
> > > 
> > 
> > Tony,
> > I was referring to initial 2 baseport patches which we have dropped due 
> > dependency on mach-types.
> > 
> > arm:omap:am33xx: Add AM335XEVM machine support
> > arm:omap:am33xx: Add low level debugging support
> 
> Can you please repost these against current v3.4-rc4? 
>  

Ok, I will do that.

> > One patch (which was independent) from this series, made its way to upstream,
> > ARM: OMAP2+: id: Add am33xx SoC type detection
> 
> OK
>  
> > Can you please make sure that, it gets included into your next pull request?
> 
> As far as I remember they looked OK for minimal board changes.
> 

Yes, they were accepted and were also available under linux-omap/soc2 branch 
for quite some time.

Thanks,
Vaibhav
