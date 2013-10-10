From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 10 Oct 2013 08:59:24 +0530
Subject: [PATCH 3/3] ARM: dts: exynos4x12: Add maudio/gps_alive power
 domain for exynos4x12
In-Reply-To: <1381365007-1782-4-git-send-email-cw00.choi@samsung.com>
References: <1381365007-1782-1-git-send-email-cw00.choi@samsung.com>
 <1381365007-1782-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAK9yfHxr27nsmaqkE+seDgZAkpUmOsPqdXdeogY89tAXYEEG2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2013 06:00, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch maudio/gps_alive power domain to exynos4x12.dtsi.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index ad531fe..c04418e 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -35,6 +35,16 @@
>                 reg = <0x10023CA0 0x20>;
>         };
>
> +       pd_maudio: maudio-power-domain at 10023CC0 {
> +               compatible = "samsung,exynos4210-pd";
> +               reg = <0x10023CC0 0x20>;
> +       };
> +
> +       pd_gps_alive: gps-alive-power-domain at 10023D04 {
> +               compatible = "samsung,exynos4210-pd";
> +               reg = <0x10023D00 0x20>;

There is mismatch between node name and register value.


-- 
With warm regards,
Sachin
