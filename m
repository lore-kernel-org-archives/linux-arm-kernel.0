From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Jan 2010 12:48:45 -0800
Subject: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle
	inside each ARCH Kconfig
In-Reply-To: <20100129102955.GA8919@n2100.arm.linux.org.uk>
References: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
	<20100129102955.GA8919@n2100.arm.linux.org.uk>
Message-ID: <20100129204845.GM23505@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100129 02:27]:
> On Fri, Jan 29, 2010 at 03:43:35PM +0900, Kukjin Kim wrote:
> > Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
> > L1 cache lines which are 64bytes to indicate this without having to
> > alter the arch/arm/mm/Kconfig entry each time.
> > 
> > Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
> > uses this and change OMAP3 and S5PC1XX to select ARM_L1_CACHE_SHIFT_6.
> 
> This looks fine, thanks.
> 
> Who's going to handle this patch?

I recommend RMK handle this.

Acked-by: Tony Lindgren <tony@atomide.com>
