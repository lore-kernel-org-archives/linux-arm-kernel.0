From: tony@atomide.com (Tony Lindgren)
Date: Sat, 9 Feb 2013 19:00:33 -0800
Subject: Latest additional build warnings
In-Reply-To: <20130209114918.GJ17852@n2100.arm.linux.org.uk>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
 <20130209114918.GJ17852@n2100.arm.linux.org.uk>
Message-ID: <20130210030032.GC4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130209 03:53]:
> On Tue, Feb 05, 2013 at 02:22:18PM +0000, Russell King - ARM Linux wrote:
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> > arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
> 
> I'm still seeing the above in the build of Friday's merge.  I'm also
> seeing additional warnings in the randconfig similar to the above for
> arch/arm/mach-omap2/omap-iommu.c.

Thanks for letting me know about the omap-iommu.c one. Looks like
there's also one patch for drm.c.

Olof, if you did not yet apply the hwspinlock.c warning fix, I'll
just do a branch with all three of them for you.

Regards,

Tony
