From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Jul 2010 13:04:54 +0900
Subject: ARM Kernel autobuilder
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6254BEF@dbde02.ent.ti.com>
References: <20100722111412.GB10399@kyllikki.org>
	<20100722132400.GR31293@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C6254BEF@dbde02.ent.ti.com>
Message-ID: <20100723040454.GA30291@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 07:11:05PM +0530, Shilimkar, Santosh wrote:
> On Thu, Jul 22, 1010 at  6:54 PM, Russell King - ARM Linux wrote:
> > On Thu, Jul 22, 2010 at 12:14:12PM +0100, Vincent Sanders wrote:
> > > Can I propose now the omap3_defconfig is working that the duplicate
> > > defconfigs are removed, these are:
> > >
> > > cm_t35_defconfig
> > > devkit8000_defconfig
> > > igep0020_defconfig
> > > rx51_defconfig
> > > omap3_beagle_defconfig
> > > omap3_evm_defconfig
> > > am3517_evm_defconfig
> > > omap_4430sdp_defconfig
> > > omap_ldp_defconfig
> > > omap3_pandora_defconfig
> > > omap3_stalker_lks_defconfig
> > > omap_apollon_2420_defconfig
> > > omap_h4_2420_defconfig
> > > omap_2430sdp_defconfig
> > > omap_3430sdp_defconfig
> > > omap_3630sdp_defconfig
> > > omap3_touchbook_defconfig
> > > omap_zoom2_defconfig
> > > omap_zoom3_defconfig
> > > overo_defconfig
> > >
> > > This would reduce the default configuration count to 156
> > > configurations.
> > 
> > Linus lately appears to be more relaxed about this, and is in the mood
> > for improvements in the situation, so yes this would be an improvement.
> > It certainly would make things a little smaller, and allow kautobuild
> > to run faster.
> > 
> omap_4430sdp_defconfig is not duplicate. Please keep omap_4430sdp_defconfig because omap3_defconfig doen't includes SMP build.

Are there any other reasons to keep omap_4430sdp_defconfig?
SMP seems to be a weak argument to me, after all if I peek in to
arch/x86/configs/ I don't see SMP and non-SMP variants.
