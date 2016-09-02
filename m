From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 2 Sep 2016 18:30:25 +0200
Subject: [GIT PULL 4/4] ARM: defconfig: Exynos for v4.9
In-Reply-To: <4575445.BeuOIIGatt@wuerfel>
References: <1472548739-20050-1-git-send-email-k.kozlowski@samsung.com>
 <1472548739-20050-2-git-send-email-k.kozlowski@samsung.com>
 <4575445.BeuOIIGatt@wuerfel>
Message-ID: <20160902163025.GA5534@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 05:47:11PM +0200, Arnd Bergmann wrote:
> On Tuesday, August 30, 2016 11:18:56 AM CEST Krzysztof Kozlowski wrote:
> > Expected conflict in multi_v7 - take all the changes:
> > 
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@@ -135,8 -136,7 +136,8 @@@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=
> >   CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> >   CONFIG_CPU_FREQ_GOV_USERSPACE=m
> >   CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> > - CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
> > + CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> >  +CONFIG_ARM_IMX6Q_CPUFREQ=y
> >   CONFIG_QORIQ_CPUFREQ=y
> >   CONFIG_CPU_IDLE=y
> >   CONFIG_ARM_CPUIDLE=y
> > 
> > 
> 
> I pulled this into next/defconfig, but didn't see the conflict,
> presumably I'll get it after merging the other branches?

The conflict is between my tree and imx-mxs tree so you might encounter
it later when merging IMX changes.

Best regards,
Krzysztof
