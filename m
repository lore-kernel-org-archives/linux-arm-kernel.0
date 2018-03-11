From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 11 Mar 2018 18:43:58 +0100
Subject: [PATCH v3 4/6] ARM: dts: exynos: Enable HDMI audio on Snow
 Chromebook
In-Reply-To: <20180309172250.23019-4-s.nawrocki@samsung.com>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172436epcas2p20e1da46084c1dcc67d6dd6cd1bf24368@epcas2p2.samsung.com>
 <20180309172250.23019-4-s.nawrocki@samsung.com>
Message-ID: <20180311174358.2kfafhdzigw2eve3@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 06:22:48PM +0100, Sylwester Nawrocki wrote:
> This patch adds new cpu, codec subnodes according to the updated
> "google,snow-audio-max98095" DT bindings and the I2S clock tree
> configuration so sound on the HDMI interface can also be supported.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - i2s0/#clock-cells property moved to exynos5250.dtsi
>  - edited commit summary line.
> 
> Changes since v1:
>  - changed order of codec in codec/cpu-dai property
>    to match the DT bindings documentation.
> ---
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +++
>  arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
>  arch/arm/boot/dts/exynos5250.dtsi             | 1 +
>  3 files changed, 12 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
