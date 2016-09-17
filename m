From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 17 Sep 2016 19:55:53 +0200
Subject: [RFC PATCH 00/10] ARM: dts: exynos: Fix invalid GIC interrupt
 flags
In-Reply-To: <CAGOxZ50WiEVGNKf_1_8DQiKruxY=0813dko18fPfuRqxeyud0A@mail.gmail.com>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
 <CAGOxZ50WiEVGNKf_1_8DQiKruxY=0813dko18fPfuRqxeyud0A@mail.gmail.com>
Message-ID: <20160917175553.GA9499@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2016 at 11:05:39PM +0530, Alim Akhtar wrote:
> Hi Krzysztof,
> 
> On Sat, Sep 17, 2016 at 1:12 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> > Marek (internally), Geert and Alban reported errors like:
> >         genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
> > The patchset fixes this issue.
> >
> > Tested on:
> > 1. Exynos4412: Odroid U3,
> > 2. Exynos5410: Odroid XU,
> > 3. Exynos5422: Odroid XU3.
> >
> 
> Tested on Exynos5800 based peach-pi board, so fpr patch 06/10
> 
> Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> 
> > Other platforms not tested so testing would be highly appreciated.
> >
> > Best regards,
> > Krzysztof
> >
> > Krzysztof Kozlowski (10):
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4210
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4x12
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4415
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos3250
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5250
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in
> >     exynos5410/exynos542x
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5260
> >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5440
> >
> 
> In general these patches looks good, feel free to add my review-by tag
> for this series.
> 
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> 

Thanks, I'll add your reviewed-by to all patches.

Best regards,
Krzysztof
