From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Mar 2012 12:17:44 -0700
Subject: [PATCH v2 0/4] ARM: OMAP: boards: changes to support dynamic
 irq alloc
In-Reply-To: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120319191743.GB9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [120319 05:09]:
> These two patches incorporate changes to OMAP1 and OMAP2 platforms
> board files whereby older references to OMAP_GPIO_IRQ macro are
> now replaced with gpio_to_irq(), thereby getting rid of static
> irq references.
> 
> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git omap/dt
> Commit: 9a0cee711448335ec43eae83272495e9334c0098

Can you please tell the exact two commits causing this
breakage?

I'm baffled how despite all the effort for previnting
issues like this this still happen. These all seem valid
fixes and clean up things, but how come this was not seen
earlier?

Regards,

Tony
