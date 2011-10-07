From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Oct 2011 00:00:12 +0100
Subject: [PATCH] ARM: PM: build sleep/suspend code for idle path also
	(not only suspend)
In-Reply-To: <8739f4ju2m.fsf@ti.com>
References: <1318026686-20191-1-git-send-email-khilman@ti.com>
	<20111007223922.GC26805@n2100.arm.linux.org.uk>
	<8739f4ju2m.fsf@ti.com>
Message-ID: <20111007230012.GD26805@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 03:49:37PM -0700, Kevin Hilman wrote:
> I see this in Arnd's randconfig/arm branch but not yet in
> arm-soc/for-next.   Is this being queued for v3.2?

Yes.

> This will also conflict with your devel-stable where the suspend.c is
> added.

Already sorted.
