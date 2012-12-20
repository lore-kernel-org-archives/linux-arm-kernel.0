From: ajaynumb@gmail.com (Ajay kumar)
Date: Thu, 20 Dec 2012 18:19:43 +0530
Subject: [PATCH 1/3] ARM: dts: Add device tree node for G2D controller on
 Exynos5
In-Reply-To: <1354112989-3161-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1354112989-3161-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <CAEC9eQPV9U73+O6uW9=fkzWcr-4djriL5aTk-kF9smvcqvRKCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping.

On Wed, Nov 28, 2012 at 7:59 PM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 581e57a..6d50c15 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -613,4 +613,10 @@
>                 reg = <0x14450000 0x10000>;
>                 interrupts = <0 94 0>;
>         };
> +
> +       g2d: g2d {
> +               compatible = "samsung,exynos-g2d-41";
> +               reg = <0x10850000 0x1000>;
> +               interrupts = <0 91 0>;
> +       };
>  };
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
