From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Jun 2012 03:50:36 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: fix naming collision of variable nr_irqs
In-Reply-To: <1340620000-27074-1-git-send-email-svenkatr@ti.com>
References: <1340620000-27074-1-git-send-email-svenkatr@ti.com>
Message-ID: <20120626105035.GC31393@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Venkatraman S <svenkatr@ti.com> [120625 03:31]:
> Using nr_irqs as local variable name triggers the sparse warning..
> ./arch/arm/mach-omap2/irq.c:265:6: warning: symbol 'nr_irqs' shadows an earlier one
> ./linux/include/linux/irqnr.h:26:12: originally declared here

Thanks applying both into fixes-non-critical.

Tony
