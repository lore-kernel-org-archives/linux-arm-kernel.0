From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 17:43:52 +0100
Subject: [GIT PULL 1/3] ARM: dts: exynos: DTS for v4.16
In-Reply-To: <20171220173643.5840-3-krzk@kernel.org>
References: <20171220173643.5840-1-krzk@kernel.org>
 <20171220173643.5840-3-krzk@kernel.org>
Message-ID: <CAK8P3a3mvT5Sa-kLRVRcH-2FZUAzWZ76Y07sJdgC-YcawRM4aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> ----------------------------------------------------------------
> Samsung DTS ARM changes for 4.16
>
> 1. Add sound support to Odroid XU4 (and adjustments to Odroid XU3).
> 2. Enable WiFi on Trats2.
> 3. Add CPU perf counters to Exynos54xx.
> 4. Add power domains to certain chipsets.
> 5. Add Exynos4412 ISP clock controller which finally solves freezes when
>    accessing ISP clocks while having the ISP power domain turned off.
> 6. Add Pseudo and True RNG to Exynos5.
> 7. Minor fixes for Trats2, Odroid XU3/XU4, Exynos5410.
> 8. Cleanup of some of DTC warnings

Pulled into next/dt, thanks!

        Arnd
