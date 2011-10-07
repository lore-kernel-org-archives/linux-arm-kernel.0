From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 22:14:31 +0200
Subject: ARM SoC tree: OMAP PM dependency on tip irq/core
In-Reply-To: <alpine.LFD.2.02.1110072056050.3240@ionos>
References: <87aa9mm8ts.fsf@ti.com> <201110072053.41594.arnd@arndb.de>
	<alpine.LFD.2.02.1110072056050.3240@ionos>
Message-ID: <201110072214.31557.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 October 2011, Thomas Gleixner wrote:
> For your internal dependecies, yes. But for irq/core you don't have to
> wait. You just need to tell Linus in the pull request that you pulled
> my branch with my ack as it contains modifications which are
> prerequisite for arm/whatever.
> 
> When I send my pull request later, then this wont do any damage as
> Linus has the commits already. Same the other way round. We do that
> all the time, otherwise pull dependencies would be a nightmare.

Ok, makes sense.

Thanks,

	Arnd
