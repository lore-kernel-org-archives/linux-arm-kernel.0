From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 11 Mar 2018 18:44:21 +0100
Subject: [PATCH v3 2/6] ARM: dts: exynos: Add audio clocks configuration
 for exynos5250-snow
In-Reply-To: <20180309172250.23019-2-s.nawrocki@samsung.com>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172404epcas1p446cf7033027ccefe2d8cfcfc49edc179@epcas1p4.samsung.com>
 <20180309172250.23019-2-s.nawrocki@samsung.com>
Message-ID: <20180311174421.ooontplgqqo4xdxl@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 06:22:46PM +0100, Sylwester Nawrocki wrote:
> Currently the audio subsystem clocks are not configured properly on Snow
> and sound is not working. The MAX98095 CODEC is not getting its master clock
> on the MCLK pin connected to the SOC's CLKOUT GPIO. This patch adds CLKOUT
> and other clocks configuration so HDMI audio can also be supported.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - edited commit summary line.
> ---
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
