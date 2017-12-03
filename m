From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 3 Dec 2017 13:07:27 +0100
Subject: [PATCH] ARM: dts: exynos: Add missing interrupt-controller
 properties to Exynos5410 PMU
In-Reply-To: <20171129183610.26305-1-krzk@kernel.org>
References: <20171129183610.26305-1-krzk@kernel.org>
Message-ID: <20171203120727.f32ynwpgploef7eu@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 07:36:10PM +0100, Krzysztof Kozlowski wrote:
> PMU (system-controller at 10040000) is used as interrupt-parent for certain
> nodes thus it should be marked as interrupt-controller to silence
> warnings when building Exynos5410-based DTBs:
> 
>   arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property):
>     Missing interrupt-controller or interrupt-map property in /soc/system-controller at 10040000
>   arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property):
>     Missing #interrupt-cells in interrupt-parent /soc/system-controller at 10040000
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5410.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

For the record, applied.

Best regards,
Krzysztof
