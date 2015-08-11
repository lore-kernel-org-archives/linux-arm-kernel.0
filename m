From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 11 Aug 2015 16:51:36 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable cpufreq-dt driver
In-Reply-To: <55C98E17.9040303@osg.samsung.com>
References: <1439259354-32055-1-git-send-email-k.kozlowski@samsung.com>
 <55C98E17.9040303@osg.samsung.com>
Message-ID: <057e01d0d40a$8c3a3210$a4ae9630$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello Krzysztof,
> 
> On 08/11/2015 04:15 AM, Krzysztof Kozlowski wrote:
> > With the latest patches the cpufreq-dt can be used on multiple
> > Exynos SoCs: 3250, 4210, 4212, 4412 and 5250.
> >
> > Enable it along with default ondemand governor to conserve the energy,
> > reduce temperature while maintaining acceptable performance.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/configs/exynos_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> > index 67965cedeb69..2263cd94cb93 100644
> > --- a/arch/arm/configs/exynos_defconfig
> > +++ b/arch/arm/configs/exynos_defconfig
> > @@ -27,6 +27,8 @@ CONFIG_ARM_APPENDED_DTB=y
> >  CONFIG_ARM_ATAG_DTB_COMPAT=y
> >  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200
> init=/linuxrc mem=256M"
> >  CONFIG_CPU_FREQ=y
> > +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> > +CONFIG_CPUFREQ_DT=y
> >  CONFIG_CPU_IDLE=y
> >  CONFIG_ARM_EXYNOS_CPUIDLE=y
> >  CONFIG_VFP=y
> >
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
Thanks, applied.

- Kukjin
