From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 04 Feb 2015 14:54:59 +0100
Subject: [PATCH v5 00/18] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <CAOhR-w3xdFtNGi=cfEM=N4ntjrjGwMUzxnqHWoRwy6r-AQOAjA@mail.gmail.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
 <CAOhR-w3xdFtNGi=cfEM=N4ntjrjGwMUzxnqHWoRwy6r-AQOAjA@mail.gmail.com>
Message-ID: <54D224B3.5070806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-02-04 10:53, Hongbo Zhang wrote:
> This is patch set against v3.19-rc4 plus 'Add HDMI support for
> Exynos5420 platform', right?
> No other dependencies? If there is, do you have a public git tree to be cloned?

I've just prepared public branch based on v3.19-rc7 with
kgene/v3.20-next/dt-samsung-3 branch merged and exynos-hdmi patches applied.

It is available here:
http://git.linaro.org/git-ro/people/marek.szyprowski/linux-srpol.git 
v3.19-hdmi-iommu

Tested with Exynos5422-based Odroid XU3 and Exynos4412-based Odroid U3.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
