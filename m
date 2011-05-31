From: tony@atomide.com (Tony Lindgren)
Date: Tue, 31 May 2011 03:23:30 -0700
Subject: [PATCH] OMAP4: SRAM: Fix warning: format '%08lx' expects type
	'long unsigned int'
In-Reply-To: <20110503105555.GR2092@atomide.com>
References: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com>
	<20110404091223.GA19854@n2100.arm.linux.org.uk>
	<4D9993AD.3080401@ti.com>
	<20110428140953.GD19709@n2100.arm.linux.org.uk>
	<20110503105555.GR2092@atomide.com>
Message-ID: <20110531102330.GS11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110503 03:52]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110428 07:06]:
> > 
> > This looks much better.
> > 
> > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > It looks like Tony hasn't taken it...  Tony, are you going to handle
> > this patch?
> 
> I can add it into my devel-cleanup branch for next merge window
> assuming it won't conflict with your sram changes. If there's a
> conflict, then you can take it.
> 
> I'd rather not merge it in the -rc cycle this late as it's not
> in the oopses or major regressions category.

Got this one finally queued as a fix.

Tony
