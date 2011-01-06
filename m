From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 6 Jan 2011 22:05:52 +0530
Subject: [PATCH] omap: wd_timer: Fix crash frm
	wdt_probewhen!CONFIG_RUNTIME_PM
In-Reply-To: <20110106152638.GC1198@n2100.arm.linux.org.uk>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
	<20110105221839.GD8717@n2100.arm.linux.org.uk>
	<19b4a66bfdd4ef3e51fdb27bf43b9ce2@mail.gmail.com>
	<20110106152638.GC1198@n2100.arm.linux.org.uk>
Message-ID: <7a7e28065232cb3b196a3813a891225f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, January 06, 2011 8:57 PM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; Paul Walmsley; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] omap: wd_timer: Fix crash frm
> wdt_probewhen!CONFIG_RUNTIME_PM
>
[.....]

> >
> > Yes. That's managed through the shutdown part. Apart from that
> there
> > is another enhancement done in case some one wants to have WDT
> running
> > throughout the kernel boot.
>
> Good - and just to confirm, the fix for LDP watchdogging will be
> submitted
> in the current merge window?

Yes. It's in the queue already.
