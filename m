From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 22 Jul 2010 19:11:05 +0530
Subject: ARM Kernel autobuilder
In-Reply-To: <20100722132400.GR31293@n2100.arm.linux.org.uk>
References: <20100722111412.GB10399@kyllikki.org>
	<20100722132400.GR31293@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6254BEF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux
> Sent: Thursday, July 22, 2010 6:54 PM
> To: Vincent Sanders
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: ARM Kernel autobuilder
> 
> On Thu, Jul 22, 2010 at 12:14:12PM +0100, Vincent Sanders wrote:
> > Can I propose now the omap3_defconfig is working that the duplicate
> > defconfigs are removed, these are:
> >
> > cm_t35_defconfig
> > devkit8000_defconfig
> > igep0020_defconfig
> > rx51_defconfig
> > omap3_beagle_defconfig
> > omap3_evm_defconfig
> > am3517_evm_defconfig
> > omap_4430sdp_defconfig
> > omap_ldp_defconfig
> > omap3_pandora_defconfig
> > omap3_stalker_lks_defconfig
> > omap_apollon_2420_defconfig
> > omap_h4_2420_defconfig
> > omap_2430sdp_defconfig
> > omap_3430sdp_defconfig
> > omap_3630sdp_defconfig
> > omap3_touchbook_defconfig
> > omap_zoom2_defconfig
> > omap_zoom3_defconfig
> > overo_defconfig
> >
> > This would reduce the default configuration count to 156
> > configurations.
> 
> Linus lately appears to be more relaxed about this, and is in the mood
> for improvements in the situation, so yes this would be an improvement.
> It certainly would make things a little smaller, and allow kautobuild
> to run faster.
> 
omap_4430sdp_defconfig is not duplicate. Please keep omap_4430sdp_defconfig because omap3_defconfig doen't includes SMP build.

Regards,
Santosh

 
