From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Nov 2010 16:59:23 -0800
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
	disabled
In-Reply-To: <87oc9e5j4c.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<87oc9e5j4c.fsf@deeprootsystems.com>
Message-ID: <20101125005923.GE31536@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101124 16:32]:
> Paul Walmsley <paul@pwsan.com> writes:

<snip>

> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Very nice.  I've been exploring various solutions to this problem as
> well, but this one is much cleaner.  Also, I hadn't discovered the 'try'
> version of the console semaphore, so was running into recursive locking.
> 
> Anyways, tested on omap35xx: omap3evm (uart1/core console) and beagle
> (uart3/per console) and omap34xx/n900 (uart3/per console) using both
> retention-idle and off-idle.

Thanks, queuing this as fix for the -rc cycle.

Tony
