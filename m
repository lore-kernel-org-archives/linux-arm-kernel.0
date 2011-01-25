From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jan 2011 18:09:09 +0530
Subject: [PATCH 4/5] ARM: scu: Move register defines to header file
In-Reply-To: <20110125122924.GF13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
	<20110125114635.GB13300@n2100.arm.linux.org.uk>
	<236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
	<20110125121655.GD13300@n2100.arm.linux.org.uk>
	<20110125122924.GF13300@n2100.arm.linux.org.uk>
Message-ID: <f2acc7ff1572649863feb3cb0f6c79ee@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 5:59 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas at arm.com; linus.ml.walleij at gmail.com; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> ccross at android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> I did mean to include the updated patch:

As said in other email will work towards this.

>
>  arch/arm/include/asm/smp_scu.h |    5 +++++
>  arch/arm/kernel/smp_scu.c      |   23 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
>
[....]

>
> If we need a SMC call, that should happen within the spinlock'd
> region via
> a function pointer which the platform can set.  I can't code that
> into this
> patch until I know what the SMC call requires as arguments (cpu
> number,
> power state, or new register value, or mask and bits to set?)

No problem. Will update SMC stuff if needed.

Regards,
Santosh
