From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 2 Aug 2016 11:52:35 +0530
Subject: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
Message-ID: <57A03C2B.2080407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 01 August 2016 04:42 PM, Kishon Vijay Abraham I wrote:
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/Kconfig                 |    2 --
>  arch/arm/mach-at91/Kconfig       |    1 -
>  arch/arm/mach-axxia/Kconfig      |    1 -
>  arch/arm/mach-exynos/Kconfig     |    1 -
>  arch/arm/mach-integrator/Kconfig |    1 -
>  arch/arm/mach-keystone/Kconfig   |    1 -
>  arch/arm/mach-ks8695/Kconfig     |    5 -----
>  arch/arm/mach-pxa/Kconfig        |    1 -
>  arch/arm/mach-spear/Kconfig      |    1 -
>  arch/arm/mach-versatile/Kconfig  |    1 -

Thank you everyone for reviewing this patch.
Looks like ARCH_IXP4XX, ARCH_DOVE, ARCH_KS8695, ARCH_PXA are not converted to
multiplatform. I'll fix this patch accordingly and repost the series.

Thanks
Kishon
