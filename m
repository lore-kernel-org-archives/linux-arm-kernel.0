From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 11:49:18 +0000
Subject: Latest additional build warnings
In-Reply-To: <20130205142218.GB17833@n2100.arm.linux.org.uk>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
Message-ID: <20130209114918.GJ17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 02:22:18PM +0000, Russell King - ARM Linux wrote:
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used

I'm still seeing the above in the build of Friday's merge.  I'm also
seeing additional warnings in the randconfig similar to the above for
arch/arm/mach-omap2/omap-iommu.c.
