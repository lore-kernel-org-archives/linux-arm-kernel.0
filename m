From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Jan 2015 08:21:12 -0800
Subject: [PATCH v11 1/9] ARM: OMAP2+: use common l2cache initialization
 code
In-Reply-To: <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
References: <1420460348-20302-1-git-send-email-m.szyprowski@samsung.com>
 <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150105162111.GA4081@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Szyprowski <m.szyprowski@samsung.com> [150105 04:22]:
> This patch implements generic DT L2C initialisation (the one from
> init_IRQ in arch/arm/kernel/irq.c) for Omap4 and AM43 platforms and
> kills the SoC specific stuff in arch/arm/mach-omap2/omap4-common.c.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Seems to work just fine for me:

Acked-by: Tony Lindgren <tony@atomide.com>
