From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 8 Oct 2018 13:51:20 +0200
Subject: [PATCH v1 1/2] mmc: dt-bindings: add "bus-clk" for MT2712
In-Reply-To: <1538188195-3608-1-git-send-email-chaotian.jing@mediatek.com>
References: <1538188195-3608-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CAPDyKFoS82cFE=C0OXLa3rULET7QsMW0dOt0B_jJ61C6G2bPGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 September 2018 at 04:29, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On MT2712 MSDC0/3, HCLK/bus-clk need gate/ungate together,
> or will hang when access MSDC register.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index f33467a..f2208f4 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -22,6 +22,7 @@ Required properties:
>         "source" - source clock (required)
>         "hclk" - HCLK which used for host (required)
>         "source_cg" - independent source clock gate (required for MT2712)
> +       "bus_clk" - bus clock used for internal register access (required for MT2712 MSDC0/3)
>  - pinctrl-names: should be "default", "state_uhs"
>  - pinctrl-0: should contain default/high speed pin ctrl
>  - pinctrl-1: should contain uhs mode pin ctrl
> --
> 1.8.1.1.dirty
>
