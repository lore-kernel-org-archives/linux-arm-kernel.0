From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 14:24:00 +0100
Subject: ARM Kernel autobuilder
In-Reply-To: <20100722111412.GB10399@kyllikki.org>
References: <20100722111412.GB10399@kyllikki.org>
Message-ID: <20100722132400.GR31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:14:12PM +0100, Vincent Sanders wrote:
> Can I propose now the omap3_defconfig is working that the duplicate
> defconfigs are removed, these are:
> 
> cm_t35_defconfig
> devkit8000_defconfig
> igep0020_defconfig
> rx51_defconfig
> omap3_beagle_defconfig
> omap3_evm_defconfig
> am3517_evm_defconfig
> omap_4430sdp_defconfig
> omap_ldp_defconfig
> omap3_pandora_defconfig
> omap3_stalker_lks_defconfig
> omap_apollon_2420_defconfig
> omap_h4_2420_defconfig
> omap_2430sdp_defconfig
> omap_3430sdp_defconfig
> omap_3630sdp_defconfig
> omap3_touchbook_defconfig
> omap_zoom2_defconfig
> omap_zoom3_defconfig
> overo_defconfig
> 
> This would reduce the default configuration count to 156
> configurations. 

Linus lately appears to be more relaxed about this, and is in the mood
for improvements in the situation, so yes this would be an improvement.
It certainly would make things a little smaller, and allow kautobuild
to run faster.
