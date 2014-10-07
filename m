From: robherring2@gmail.com (Rob Herring)
Date: Tue, 7 Oct 2014 11:28:42 -0500
Subject: [PATCH v4 4/4] arch: arm: boot: dts: Added correct vendor-prefix
 with device name to compatible property
In-Reply-To: <1412695169-22815-5-git-send-email-darshanapadmadas@gmail.com>
References: <1412695169-22815-1-git-send-email-darshanapadmadas@gmail.com>
 <1412695169-22815-5-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <CAL_Jsq+BFFfh8AHc=mhm5hapHCN++5F4fHZG+KJFBGLYaOyagg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 7, 2014 at 10:19 AM, Darshana Padmadas
<darshanapadmadas@gmail.com> wrote:
> This patch adds the correct vendor-prefix listed in Documentation/devicetree/bindings/vendor-prefixes.txt
> with the device name to compatible property.

It would be nice if the subject and msg gave some clue as to which
binding and platform you are changing. Look at prior commits and
follow their pattern for subject.

Rob

>
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30-cardhu.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> index 2063795..dcc6c75 100644
> --- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
> +++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> @@ -187,7 +187,7 @@
>
>                 /* ALS and Proximity sensor */
>                 isl29028 at 44 {
> -                       compatible = "isil,isl29028";
> +                       compatible = "isl,isl29028";
>                         reg = <0x44>;
>                         interrupt-parent = <&gpio>;
>                         interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
> --
> 1.9.1
>
