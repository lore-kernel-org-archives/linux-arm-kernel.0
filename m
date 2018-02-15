From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 15 Feb 2018 19:32:34 +0100
Subject: [PATCH v3 2/3] ARM: dts: exynos: Update I2S0 device node in
 exynos5433.dtsi
In-Reply-To: <20180212163147.11561-2-s.nawrocki@samsung.com>
References: <20180212163147.11561-1-s.nawrocki@samsung.com>
 <CGME20180212163207epcas1p19d0fd84633edda6f61a7b760b85e1c91@epcas1p1.samsung.com>
 <20180212163147.11561-2-s.nawrocki@samsung.com>
Message-ID: <20180215183234.sbr5uvobjyynfpdj@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 05:31:46PM +0100, Sylwester Nawrocki wrote:
> The i2s0 node name is changed to a more generic "i2s" and missing
> (optional) properties are added. The #sound-dai-cells property is
> required for HDMI audio support on TM2 board.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - none.
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof
