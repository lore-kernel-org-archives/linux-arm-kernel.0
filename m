From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 31 Jan 2017 12:10:11 +0100
Subject: [PATCH] dt-bindings: mmc: sunxi: Document A64 eMMC compatible
In-Reply-To: <20170130132713.20750-1-maxime.ripard@free-electrons.com>
References: <20170130132713.20750-1-maxime.ripard@free-electrons.com>
Message-ID: <CAPDyKFp8OL7HfB5KK0r74hbfTTsjs5CZntpn3dR1BKJ6E+-6qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2017 at 14:27, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> We introduced recently a new compatible to deal with the A64 eMMC
> controller, let's document its binding.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks, applied for next!

I also added Rob's ack as he already acked the patch parsing the new
compatible in the driver.

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 55cdd804cdba..7d53a799f140 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -13,6 +13,7 @@ Required properties:
>     * "allwinner,sun5i-a13-mmc"
>     * "allwinner,sun7i-a20-mmc"
>     * "allwinner,sun9i-a80-mmc"
> +   * "allwinner,sun50i-a64-emmc"
>     * "allwinner,sun50i-a64-mmc"
>   - reg : mmc controller base registers
>   - clocks : a list with 4 phandle + clock specifier pairs
> --
> 2.11.0
>
