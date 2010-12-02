From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Dec 2010 09:37:43 -0000
Subject: Forced HW_BREAKPOINT
In-Reply-To: <4CF6AC9B.9060500@ti.com>
References: <4CF58F22.6070803@ti.com>
	<004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
	<4CF67525.2010304@ti.com>
	<004d01cb9174$c8d83ec0$5a88bc40$@deacon@arm.com>
	<4CF67C52.4000300@ti.com>
	<004f01cb917d$c04b4910$40e1db30$@deacon@arm.com>
	<4CF6AC9B.9060500@ti.com>
Message-ID: <005501cb9204$923e1de0$b6ba59a0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Please can you try this patch?
> >
> [...]
> >
> >
> > This should cause the hw_breakpoint stuff to give up if monitor-mode
> > cannot be enabled.
> 
> Could we also scale down the WARN_ONs in enable_monitor_mode?

That was my next step, I just wanted to make sure that those
changes allow you to get to a prompt (since I don't have any
1176 hardware). I have a bunch of changes pending in this area
so I'll add this to the stack.

Will
