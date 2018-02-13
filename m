From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 13 Feb 2018 18:56:43 +0100
Subject: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg
 warning for syscon restart nodes
In-Reply-To: <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
References: <CGME20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9@epcas1p2.samsung.com>
 <20180130211819.17139-1-krzk@kernel.org>
 <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
Message-ID: <20180213175643.4h5anubed4w4lclb@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 08, 2018 at 02:46:32PM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-01-30 22:18, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Changes since v1:
> > 1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
> >     following Rob's advice.
> > 2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
> >     on this.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested following boards and reboot works fine:
> Exynos3250 (artik5-eval)
> Exynos4412 (trats2)
> Exynos5410 (odroid xu)
> Exynos5422 (odroid xu3/xu4)
> Exynos5433 (tm2)

Thanks for testing. I applied 1/4 and 2/4. The remaining DTS patches
depend on 1/4 so they will wait till next release.

Best regards,
Krzysztof
