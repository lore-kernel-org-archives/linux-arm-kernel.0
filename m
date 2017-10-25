From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 25 Oct 2017 23:11:28 +0200
Subject: [PATCH v6 03/12] arm64: dts: mt8173: remove "mediatek, mt8135-mmc"
 from mmc nodes
In-Reply-To: <1508118399-21828-4-git-send-email-chaotian.jing@mediatek.com>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
 <1508118399-21828-4-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CAPDyKFrRVT8YFXvy3Wuf_jga5oourScOdas34U=YkeLRzHoWMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2017 at 03:46, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> devicetree bindings has been updated to support multi-platforms,
> so that each platform has its owns compatible name.
> And, this compatible name may used in driver to distinguish with
> other platform.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Matthias, do you intend to pick this? Else I can do it with your ack...

Kind regards
Uffe

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index b99a273..26396ef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -682,8 +682,7 @@
>                 };
>
>                 mmc0: mmc at 11230000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11230000 0 0x1000>;
>                         interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_0>,
> @@ -693,8 +692,7 @@
>                 };
>
>                 mmc1: mmc at 11240000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11240000 0 0x1000>;
>                         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_1>,
> @@ -704,8 +702,7 @@
>                 };
>
>                 mmc2: mmc at 11250000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11250000 0 0x1000>;
>                         interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_2>,
> @@ -715,8 +712,7 @@
>                 };
>
>                 mmc3: mmc at 11260000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11260000 0 0x1000>;
>                         interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_3>,
> --
> 1.8.1.1.dirty
>
