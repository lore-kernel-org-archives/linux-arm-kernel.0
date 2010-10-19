From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Oct 2010 15:49:15 -0700
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <4CBD8BC2.3020000@ti.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<4CBD8BC2.3020000@ti.com>
Message-ID: <20101019224915.GD3038@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Anand Gadiyar <gadiyar@ti.com> [101019 05:06]:
> On 10/19/2010 5:07 PM, Catalin Marinas wrote:
> >On Tue, 2010-10-19 at 11:18 +0100, Anand Gadiyar wrote:
> >>Commit ba1b9be5cd in linux-next (ARM: Add SWP/SWPB emulation for ARMv7
> >>processors (v5)) introduced arch/arm/kernel/swp_emulate.c. This file
> >>gets compiled when the omap2plus_defconfig is built - the
> >>omap2plus_defconfig builds OMAP2420, OMAP2430, OMAP3 and OMAP4 in one
> >>image, and has CPU_V6 and CPU_V7 both enabled.
> >
> >This patch should fix it:
> >
> 
> Yes, it does. I've not yet boot tested on omap2; will try
> that out in a bit.

Thanks that fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
