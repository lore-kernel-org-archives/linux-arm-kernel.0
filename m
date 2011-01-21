From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 10:52:01 +0000
Subject: [PATCH] ARM: mxs: irq_data conversion
In-Reply-To: <20110121104742.GC23596@mail.wantstofly.org>
References: <1295600518-11300-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110121094338.GE13235@n2100.arm.linux.org.uk>
	<20110121101536.GH14956@pengutronix.de>
	<20110121102707.GH13235@n2100.arm.linux.org.uk>
	<20110121104742.GC23596@mail.wantstofly.org>
Message-ID: <20110121105201.GL13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:47:42AM +0100, Lennert Buytenhek wrote:
> On Fri, Jan 21, 2011 at 10:27:07AM +0000, Russell King - ARM Linux wrote:
> For msm, gpio-v2.c doesn't get built by any defconfig since
> there is no defconfig that sets ARCH_MSM8X60, irq-kev7a400.c is never
> even referenced in arch/arm/mach-lh7a40x/Makefile so it never gets
> built at all, and the other platforms I didn't see as I built against
> -linus and ARM devel-stable rather than against ARM devel.

Okay, ignore the lh7a40x stuff - I think we really should kill that
off as its not receiving anything but our updates, and it's clearly
not right.
