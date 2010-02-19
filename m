From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 20 Feb 2010 08:01:10 +0900
Subject: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle
	inside each ARCH Kconfig
In-Reply-To: <20100129204845.GM23505@atomide.com>
References: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
	<20100129102955.GA8919@n2100.arm.linux.org.uk>
	<20100129204845.GM23505@atomide.com>
Message-ID: <00a201cab1b7$6ff6feb0$4fe4fc10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100129 02:27]:
> > On Fri, Jan 29, 2010 at 03:43:35PM +0900, Kukjin Kim wrote:
> > > Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
> > > L1 cache lines which are 64bytes to indicate this without having to
> > > alter the arch/arm/mm/Kconfig entry each time.
> > >
> > > Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
> > > uses this and change OMAP3 and S5PC1XX to select
> ARM_L1_CACHE_SHIFT_6.
> >
> > This looks fine, thanks.
> >
> > Who's going to handle this patch?
> 
> I recommend RMK handle this.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Hi Tony and Russell,

I wonder this patch who does/did handle.
Please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
