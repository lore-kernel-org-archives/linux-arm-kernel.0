From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Oct 2011 11:06:24 -0700
Subject: [PATCH 13/30] ARM: omap2+: fix omap_hdq_init compilation
In-Reply-To: <4E8943EA.5060205@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-14-git-send-email-arnd@arndb.de>
	<4E8943EA.5060205@ti.com>
Message-ID: <20111003180624.GX6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111002 21:37]:
> On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> > The definition of the device must depend on the hardware
> > we run on, not on the kernel configuration.
> > 
> > arch/arm/mach-omap2/devices.c:624:13: error: 'OMAP_HDQ_BASE' undeclared here (not in a function)
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
