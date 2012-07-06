From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Jul 2012 05:36:11 -0700
Subject: [PATCH v2 00/14] ARM: OMAP5: Add minimal OMAP5 SOC support
In-Reply-To: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120706123611.GW1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120706 02:26]:
> Tony,
> 
> Here is the updated series with suggested corrections and generated against
> the latest cleanup-part2 at commit ae6df418. The series adds minimal OMAP5
> support. OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
> L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and hence
> large part of the peripherals are re-used.

Looking good to me, just one cosmetic comment below:
 
>   ARM: OMAP: counter-32k: Select the CR register offset using the IP scheme.
>   ARM: OMAP5: l3: Add l3 error handler support for omap5.
>   ARM: omap2+: board-generic: clean up the irq data from board file.
>   ARM: OMAP5: board-generic: Add device tree support.
>   ARM: OMAP5: Add SMP support.

Can you please remove the trailing period from the patch title lines?
That's not typically used..

Thanks,

Tony
