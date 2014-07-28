From: spk.linux@gmail.com (Sachin Kamat)
Date: Mon, 28 Jul 2014 20:56:31 +0530
Subject: [RESEND][PATCH 1/2] ARM: DTS: Add PMU DT node for exynos5260 SoC
In-Reply-To: <1406551080-14821-2-git-send-email-vikas.sajjan@samsung.com>
References: <1406551080-14821-1-git-send-email-vikas.sajjan@samsung.com>
 <1406551080-14821-2-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAK5sBcHdsDF60JTv7ugC4m=A-5Lmr2rDwizhkCLEyYGRio-2-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

On Mon, Jul 28, 2014 at 6:07 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Adds PMU DT node for exynos5260 SoC.
>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
>  arch/arm/boot/dts/exynos5260.dtsi                  |    5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> index 2a4ab04..c038628 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -8,6 +8,7 @@ Properties:
>                    - "samsung,exynos4412-pmu" - for Exynos4412 SoC,
>                    - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
>                    - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
> +                  - "samsung,exynos5260-pmu" - for Exynos5260 SoC.

nit: This line should come after 5250 entry to preserve the order.

Otherwise, looks good.
-- 
Regards,
Sachin.
