From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 29 Jul 2013 12:07:56 +0530
Subject: [PATCH v8 06/12] ARM: dts: Add description of System MMU of
 Exynos SoCs
In-Reply-To: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
Message-ID: <CAK9yfHy2btp1W+5-GiVQnkffDnJ-CgqXuAjGktkiKYyf7kKQbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi KyongHo,

On 26 July 2013 16:58, Cho KyongHo <pullip.cho@samsung.com> wrote:
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
>  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   76 +++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |  291 ++++++++++++++++++++
>  5 files changed, 617 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt

This patch does not apply on the mainline Linus' tree (3.11-rc2). Please rebase.

-- 
With warm regards,
Sachin
