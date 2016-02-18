From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Feb 2016 09:07:16 -0800
Subject: [PATCH] clk: sunxi: Add missing H3 apb0 clock documentation
In-Reply-To: <1455807809-30827-1-git-send-email-k@japko.eu>
References: <CACRpkdbfNeh7_=3ReQtJc7OxkkQEn+BUhZ0O0SKnFsRD=WZiUQ@mail.gmail.com>
 <1455807809-30827-1-git-send-email-k@japko.eu>
Message-ID: <CAGb2v67PiQHVQfhbsk2f3aQFOaDXHy3P+NJDoTw-+GshubWaYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 7:03 AM, Krzysztof Adamski
<krzysztof.adamski@tieto.com> wrote:
> allwinner,sun8i-h3-apb0-gates-clk was added by
> commit ba83a11104ae ("pinctrl: sunxi: Add H3 R_PIO controller support")
> but the patch was missing proper binding documentation. This patch fixes
> this issue.

What are you talking about? The commit you mentioned only adds the pinctrl
driver. Your H3 PRCM related clock and reset patches are still pending.
No need for this patch as your earlier patches includes this.

ChenYu

>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index c09f59b..37d0fd6 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -38,6 +38,7 @@ Required properties:
>         "allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
>         "allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
>         "allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
> +       "allwinner,sun8i-h3-apb0-gates-clk" - for the APB0 gates on H3
>         "allwinner,sun9i-a80-apb0-clk" - for the APB0 bus clock on A80
>         "allwinner,sun8i-a83t-apb0-gates-clk" - for the APB0 gates on A83T
>         "allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
> --
> 2.1.4
>
