From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 16:29:00 -0700
Subject: [PATCH v2] ARM: OMAP3: hwmod: fix variant registration and
	remove SmartReflex from common list
In-Reply-To: <alpine.DEB.2.00.1110061723550.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
	<20111006223545.GB27281@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1110061723550.4611@utopia.booyaka.com>
Message-ID: <20111006232900.GC6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111006 15:50]:
> 
> Commit d6504acd2125984c61dce24727dd3842d0144015 ("OMAP2+: hwmod:
> remove OMAP_CHIP*") tests the inverse condition of what it should be
> testing for the return value from omap_hwmod_register().  This causes
> several IP blocks to not be registered on several OMAP3 family devices.
> 
> Fixing that bug also unmasked another bug, originally reported by
> Chase Maupin <chase.maupin@ti.com> and then subsequently by Abhilash K
> V <abhilash.kv@ti.com>, which caused SmartReflex IP blocks to be
> registered on SoCs that don't support them.
> 
> Thanks to Russell King - ARM Linux <linux@arm.linux.org.uk> for comments
> on a previous version of the patch.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Chase Maupin <chase.maupin@ti.com>
> Cc: Abhilash K V <abhilash.kv@ti.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> ---
> 
> This version incorporates some comments from RMK.

Thanks, updating in fixes-part2.

Tony
