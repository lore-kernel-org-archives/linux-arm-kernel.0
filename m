From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 Dec 2013 09:42:26 +0900
Subject: [PATCH v3 0/6] Exynos device tree clean-up for 3.14
In-Reply-To: <1386864738-19829-1-git-send-email-t.figa@samsung.com>
References: <1386864738-19829-1-git-send-email-t.figa@samsung.com>
Message-ID: <0dba01cef9f7$b1379010$13a6b030$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This series intends to fix small problems with Exynos device tree sources
> that I spotted during my work on other things. The fixes are mostly
> stylistic, without any funtional changes introduced.
> 
> Changes sinve v2:
>  - Moved MSHC patches to separate series.
>  - Rebased onto current linux-next.
> Changes since v1:
>  - Addressed Stephen Warren's comments about MCT binding documentation.
> 
> Tomasz Figa (6):
>   Documentation: devicetree: Update Exynos MCT bindings description
>   ARM: dts: exynos4: Drop interrupt controller properties from MCT nodes
>   ARM: dts: exynos4x12: Move MCT node to exynos4x12.dtsi
>   ARM: dts: exynos4: Simplify MCT interrupt map
>   ARM: dts: exynos: Fix missing spaces after labels
>   ARM: dts: exynos4: Add missing unit-address of sysreg node
> 
>  .../bindings/timer/samsung,exynos4210-mct.txt      | 54
+++++++++++++++---
> ----
>  arch/arm/boot/dts/exynos4.dtsi                     |  6 +--
>  arch/arm/boot/dts/exynos4210.dtsi                  | 23 ++++-----
>  arch/arm/boot/dts/exynos4212.dtsi                  | 24 +---------
>  arch/arm/boot/dts/exynos4412.dtsi                  | 28 +----------
>  arch/arm/boot/dts/exynos4x12.dtsi                  | 20 ++++++++
>  arch/arm/boot/dts/exynos5.dtsi                     |  4 +-
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |  6 +--
>  arch/arm/boot/dts/exynos5440.dtsi                  |  2 +-
>  9 files changed, 78 insertions(+), 89 deletions(-)
> 
> --
> 1.8.4.3

Nice cleanup series. Thanks and will apply.

- Kukjin
