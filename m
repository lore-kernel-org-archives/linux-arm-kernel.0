From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 26 Sep 2011 11:58:48 +0200
Subject: [PATCH v3 3/3] OMAP3: Remove auto-selection of PMICs
In-Reply-To: <1316698155-954-4-git-send-email-abhilash.kv@ti.com>
References: <1316698155-954-1-git-send-email-abhilash.kv@ti.com>
	<1316698155-954-2-git-send-email-abhilash.kv@ti.com>
	<1316698155-954-3-git-send-email-abhilash.kv@ti.com>
	<1316698155-954-4-git-send-email-abhilash.kv@ti.com>
Message-ID: <20110926095848.GF32263@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

On Thu, Sep 22, 2011 at 06:59:15PM +0530, Abhilash K V wrote:
> The current implementation almost assumes that only
> TWL4030/TWL5030/TWl6030 are (or can be) used with the
> OMAP processors. This is, however, not true.
> 
> This patch removes the automatic selection of the PMIC
> from Kconfig.
> All currently used PMICs are now added to omap2plus_defconfig;
> any new PMIC that gets supported in future could now be
> enabled here rather than by changing Kconfig for
> ARCH_OMAP2PLUS_TYPICAL
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/configs/omap2plus_defconfig |    3 +++
>  arch/arm/mach-omap2/Kconfig          |    3 ---
>  drivers/mfd/Kconfig                  |    2 +-
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

for the MFD part.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
