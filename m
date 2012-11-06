From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Nov 2012 10:18:16 -0800
Subject: [PATCH v2 03/14] ARM: OMAP5: id: Add cpu id for ES versions
In-Reply-To: <50939A81.8060508@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-4-git-send-email-santosh.shilimkar@ti.com>
 <50939A81.8060508@ti.com>
Message-ID: <20121106181816.GG6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [121102 03:05]:
> Hi Santosh,
> 
> I believe the change from cpu_is_xxx() to soc_is_xxx() just for OMAP5
> leads to unnecessary confusion, even though soc_is_ is more technically
> correct.

All of them will be eventually soc_is_xxx() and private to
arch/arm/mach-omap2.

Regards,

Tony
