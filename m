From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 31 Jan 2013 16:57:22 +0000 (UTC)
Subject: OMAP4 PM bootloader dependency problems
In-Reply-To: <alpine.DEB.2.00.1301311656230.32145@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
 <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
 <1359622829.10415.40.camel@sokoban> <510A54F8.4090609@ti.com>
 <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
 <510A9BFB.5070802@ti.com>
 <alpine.DEB.2.00.1301311630090.32145@utopia.booyaka.com>
 <alpine.DEB.2.00.1301311656230.32145@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1301311657040.32145@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013, Paul Walmsley wrote:

> On Thu, 31 Jan 2013, Paul Walmsley wrote:
> 
> > Right.  I don't have any problem with adding a message to the suspend path 
> > also.  But I'd like to see a boot-time message added even if 
> > CONFIG_CPU_IDLE=n, since it's still possible to enter full-chip retention 
> > idle with dynamic idle.  In other words, not everyone might use 'echo mem 
> > > /sys/power/state'.
> 
> (and re-reading my original E-mail to Rajendra, I can see that it was 
> nuclear, so I'm sorry about that.)

Hehe, _unclear_.  Time to go back to bed...


- Paul
