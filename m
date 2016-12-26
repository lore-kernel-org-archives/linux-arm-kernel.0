From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 26 Dec 2016 14:36:15 +0900
Subject: [PATCH 1/9] ARM: dts: exynos: Add PMU syscon to pinctrl nodes
In-Reply-To: <1482495889-6201-2-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161223122516epcas5p41c9d3f1e805293ee7f000d614452ba6f@epcas5p4.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <1482495889-6201-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CA+Ln22E2ybpbw-p__90g_Ndun158L-uBwxNYF+TjhwmNK6dH5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

2016-12-23 21:24 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Access to PMU regmap is needed to properly release pad retention after
> suspend/resume cycle.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4210.dtsi | 3 +++
>  arch/arm/boot/dts/exynos4x12.dtsi | 3 +++
>  arch/arm/boot/dts/exynos5250.dtsi | 4 ++++
>  arch/arm/boot/dts/exynos5420.dtsi | 5 +++++
>  5 files changed, 17 insertions(+)
>

I think the change makes sense, but we should also update binding
documentation. Also will the driver continue to work correctly if the
property is not present?

Best regards,
Tomasz
