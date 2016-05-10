From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 16:18:20 +0200
Subject: [GIT PULL] ARM: dts: exynos: Devfreq for v4.7
In-Reply-To: <1462367136-28627-1-git-send-email-k.kozlowski@samsung.com>
References: <1462367136-28627-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4199175.Sym2be3WAj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 May 2016 15:05:36 Krzysztof Kozlowski wrote:
> Topic branch for Device Tree changes adding new generic devfreq driver, for
> v4.7:
> 1. Add bus nodes for Exynos3250, Exynos4x12, Exynos4210 and Exynos542x.
> 2. Split out common PPMU (Performance Monitoring Unit) nodes into separate
>    DTSI. The PPMU provides performance data for devfreq.
> 3. Add NoCP (Network on Chip Probe) node for Exynos542x. On this SoC, like PPMU
>    on older designs, provides performance data for devfreq.
> 4. Enable DFVS (Dynamic Voltage and Frequency Scaling) on boards:
>    - Exynos3250 Rinato,
>    - Exynos4412 Odroid-X/X2/U3 and Trats2,
>    - Exynos5422 Odroid XU3/XU3-Lite/XU4.
> 
> 

Merged into next/late now, so we can track the clk dependency more easily.

Thanks,

	Arnd
