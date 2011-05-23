From: khilman@ti.com (Kevin Hilman)
Date: Mon, 23 May 2011 08:20:03 -0700
Subject: [PATCH] Fix generic irq chip
In-Reply-To: <20110523150120.GA15153@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 23 May 2011 16:01:20 +0100")
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
	<87lixx34ue.fsf@ti.com>
	<20110523150120.GA15153@n2100.arm.linux.org.uk>
Message-ID: <877h9h30m4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, May 23, 2011 at 06:48:41AM -0700, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > As a result of c42321c (genirq: Make generic irq chip depend on
>> > CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
>> > my tree to select this symbol.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > --
>> > Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
>> > for Samsung.
>> 
>> Acked-by: Kevin Hilman <khilman@ti.com>
>
> Thanks, but does that cover Davinci or OMAP?

Both, but since Sekhar (DaVinci co-maintainer) ack'd already for
davinci, I was mainly adding my ack for OMAP.

Kevin
