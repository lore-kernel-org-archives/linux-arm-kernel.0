From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 2 May 2018 19:07:51 +0200
Subject: [RFC 01/10] ARM: dts: exynos: Remove Exynos5440
In-Reply-To: <20180424203239.21885-2-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-2-krzk@kernel.org>
Message-ID: <20180502170751.5ci6hgvtlytwyvqh@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:32:30PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
> 
> Remove all Device Tree sources for Exynos5440, as first step of removal
> of the platform to simplify the code and drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   2 -
>  arch/arm/boot/dts/Makefile                         |   2 -
>  arch/arm/boot/dts/exynos5440-sd5v1.dts             |  42 ---
>  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |  81 -----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 --
>  arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  21 --
>  arch/arm/boot/dts/exynos5440.dtsi                  | 355 ---------------------
>  7 files changed, 523 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
>  delete mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440.dtsi
> 

Applied.

Best regards,
Krzysztof
