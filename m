From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 16:03:34 -0700
Subject: [PATCH-V3 1/4] arm:omap:am33xx: Update common omap platform files
In-Reply-To: <1316529142-27564-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-2-git-send-email-hvaibhav@ti.com>
Message-ID: <20111006230334.GY6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* hvaibhav at ti.com <hvaibhav@ti.com> [110920 06:59]:
> From: Afzal Mohammed <afzal@ti.com>
> 
> This patch updates the common platform files with AM335X device
> support (AM33XX family).
> 
> The approach taken in this patch is,
> AM33XX device will be considered as OMAP3 variant, and a separate
> SoC class created for AM33XX family of devices with a subclass type
> for AM335X device, which is newly added device in the family.
> 
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and cpu_is_am335x()
> checks will return success on AM335X device.
> A kernel config option CONFIG_SOC_OMAPAM33XX is added under OMAP3
> to include support for AM33XX build.
> 
> Also, cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence
> struct clksel_rate.flags, struct prcm_config.flags and cpu_mask
> are changed to u16 from u8.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Hemant Pedanekar <hemantp@ti.com>

I'll add this one into soc branch.

Regards,

Tony
