From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Feb 2017 16:19:57 +0100
Subject: [GIT PULL 4/4] arm64: dts: exynos: DT64 for v4.11, third round
In-Reply-To: <20170202183008.23500-5-krzk@kernel.org>
References: <20170202183008.23500-1-krzk@kernel.org>
 <20170202183008.23500-5-krzk@kernel.org>
Message-ID: <2382634.UqDUkYPZrI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 2, 2017 8:30:08 PM CET Krzysztof Kozlowski wrote:
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  34 +++
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |  34 +++
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  49 +++-
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    | 302 +++++++++++----------
>  arch/arm64/boot/dts/exynos/exynos7.dtsi            |  34 +++
>  drivers/clk/samsung/clk-exynos5433.c               |   8 +-
>  include/dt-bindings/clock/exynos5433.h             |   5 +-
>  include/dt-bindings/pinctrl/samsung.h              |   8 +
> 

It seems a drivers/clk change slipped in there in addition to the header changes.
We are trying to keep the next/dt branches free of driver changes, are you
able to rework the branch without this?

Sorry for the late request.

	Arnd
