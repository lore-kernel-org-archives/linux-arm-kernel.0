From: dawei.chien@mediatek.com (dawei chien)
Date: Thu, 21 Apr 2016 12:12:51 +0800
Subject: [RESEND][PATCH 3/3] arm64: dts: mt8173: Add dynamic power node.
In-Reply-To: <1458029437-12846-4-git-send-email-dawei.chien@mediatek.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
 <1458029437-12846-4-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1461211971.16427.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-15 at 16:10 +0800, Dawei Chien (???) wrote:
> This device node is for calculating dynamic power in mW.
> Since mt8173 has two clusters, there are two dynamic power
> coefficient as well.
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on patchset:
> https://lkml.org/lkml/2015/11/17/251

Sorry for miss one dependence for this device node.
https://lkml.org/lkml/2015/7/9/206

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index f9c44cc..5cb6b4e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -71,6 +71,7 @@
>                         #cooling-cells = <2>;
>                         #cooling-min-level = <0>;
>                         #cooling-max-level = <7>;
> +                       dynamic-power-coefficient = <263>;
>                 };
> 
>                 cpu1: cpu at 1 {
> @@ -95,6 +96,7 @@
>                         #cooling-cells = <2>;
>                         #cooling-min-level = <0>;
>                         #cooling-max-level = <7>;
> +                       dynamic-power-coefficient = <263>;
>                 };
> 
>                 cpu2: cpu at 100 {
> @@ -119,6 +121,7 @@
>                         #cooling-cells = <2>;
>                         #cooling-min-level = <0>;
>                         #cooling-max-level = <7>;
> +                       dynamic-power-coefficient = <530>;
>                 };
> 
>                 cpu3: cpu at 101 {
> @@ -143,6 +146,7 @@
>                         #cooling-cells = <2>;
>                         #cooling-min-level = <0>;
>                         #cooling-max-level = <7>;
> +                       dynamic-power-coefficient = <530>;
>                 };
> 
>                 idle-states {
> --
> 1.7.9.5
> 
