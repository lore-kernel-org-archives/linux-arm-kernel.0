From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 23:37:00 +0100
Subject: [PATCH] ARM: bcmring: Add clkdev table in init_early
In-Reply-To: <20110518204242.GA21384@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
	<4DD2FF02.1020508@broadcom.com>
	<20110517232015.GC5913@n2100.arm.linux.org.uk>
	<4DD307E2.7010302@broadcom.com>
	<20110518154641.GK5913@n2100.arm.linux.org.uk>
	<4DD40965.9020202@broadcom.com>
	<20110518204242.GA21384@n2100.arm.linux.org.uk>
Message-ID: <20110518223700.GC21384@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 09:42:42PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 18, 2011 at 11:01:09AM -0700, Jiandong Zheng wrote:
> > ARM: bcmring: Move adding clkdev to init_early to make sure clkevent  
> > based on sp804 is initialized properly.
> 
> Great, can you submit this to the patch system please?  Thanks.

Erm, actually this patch is against your previous patch (as is the one
which you submitted to the patch system) so it won't apply as-is.  It
needs to be one which wil apply directly to mainline in this case please.
