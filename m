From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Feb 2011 19:54:46 +0530
Subject: [PATCH 0/5] ARM: Few patches for PM enablement.
In-Reply-To: <f804b2179a222189b71c9429285de723@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<f804b2179a222189b71c9429285de723@mail.gmail.com>
Message-ID: <d6a3825e4669b02ddf62ebcc768a500c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Friday, February 04, 2011 3:49 PM
> To: Russell King - ARM Linux
> Cc: linux-omap at vger.kernel.org; ccross at android.com;
> catalin.marinas at arm.com; linus.ml.walleij at gmail.com; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH 0/5] ARM: Few patches for PM enablement.
>

> ARM: gic: Add hooks for architecture specific extensions
> ARM: gic: Add distributor and interface enable/disable accessory api
I plan to submit below to patches to your patch system.

> ARM: twd: Add context save restore support
> ARM: scu: Move register defines to header file
Alternate for these two are already in you tree, so I drop them.

> ARM: smp: Skip secondary cpu calibration to speed-up boot
This one we still haven't agree. So I postpone this one till you
find any other better way to handle this though I really hate that
~ 200 ms in this path.

Regards,
Santosh
