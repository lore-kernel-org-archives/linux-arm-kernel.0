From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 23 Nov 2018 16:20:16 +0100
Subject: [PATCH v2 1/4] dt-bindings: clock: meson8b: export the CPU post
 dividers
In-Reply-To: <20181122214017.25643-2-martin.blumenstingl@googlemail.com>
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
 <20181122214017.25643-2-martin.blumenstingl@googlemail.com>
Message-ID: <4e82df94-dcb0-57ca-c751-074012d054dd@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/2018 22:40, Martin Blumenstingl wrote:
> There are four CPU clock post dividers:
> - ABP
> - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> - AXI
> - L2 DRAM
> 
> Export these so we can use them in .dts files.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
> index a60f47b49231..5fe2923382d0 100644
> --- a/include/dt-bindings/clock/meson8b-clkc.h
> +++ b/include/dt-bindings/clock/meson8b-clkc.h
> @@ -103,5 +103,9 @@
>  #define CLKID_MPLL1		94
>  #define CLKID_MPLL2		95
>  #define CLKID_NAND_CLK		112
> +#define CLKID_ABP		124
> +#define CLKID_PERIPH		126
> +#define CLKID_AXI		128
> +#define CLKID_L2_DRAM		130
>  
>  #endif /* __MESON8B_CLKC_H */
> 

Kevin,

Martin asked my a tag for this patch since he has a dependency on it.

You can find it here :

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/BayLibre/clk-meson.git tags/meson-clk-headers-4.21-1

for you to fetch changes up to 8e1dd17c8b0e3f8c66ed2a3f88a440d36135e589:

  dt-bindings: clock: meson8b: export the CPU post dividers (2018-11-23 15:11:55 +0100)

----------------------------------------------------------------
Update for meson clocks bindings targeted at v4.21:
- Export Meson8b CPU post dividers

----------------------------------------------------------------
Martin Blumenstingl (1):
      dt-bindings: clock: meson8b: export the CPU post dividers

 include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
 1 file changed, 4 insertions(+)

Neil
