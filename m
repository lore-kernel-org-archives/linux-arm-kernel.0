From: joel@jms.id.au (Joel Stanley)
Date: Thu, 29 Sep 2016 10:24:17 +0930
Subject: [PATCH 3/8] pinctrl: aspeed-g5: Fix GPIOE1 typo
In-Reply-To: <9364de84d3be30a5349298e219ca827d176d7ba8.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <9364de84d3be30a5349298e219ca827d176d7ba8.1474986045.git-series.andrew@aj.id.au>
Message-ID: <CACPK8Xewvdj-zW7xS7PT6LPt8GJRh9_nDNew_6UeGZzmgtcT-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 12:20 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> This prevented C20 from successfully being muxed as GPIO.
>
> Fixes: 56e57cb6c07f (pinctrl: Add pinctrl-aspeed-g5 driver)
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> index 14639834a5eb..235d929e74fd 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> @@ -182,7 +182,7 @@ SIG_EXPR_LIST_DECL_SINGLE(NDCD3, NDCD3, SIG_DESC_SET(SCU80, 17));
>  SIG_EXPR_DECL(GPIE0OUT, GPIE0, GPIE0_DESC);
>  SIG_EXPR_DECL(GPIE0OUT, GPIE, GPIE_DESC);
>  SIG_EXPR_LIST_DECL_DUAL(GPIE0OUT, GPIE0, GPIE);
> -MS_PIN_DECL(C20, GPIE0, NDCD3, GPIE0OUT);
> +MS_PIN_DECL(C20, GPIOE1, NDCD3, GPIE0OUT);
>
>  FUNC_GROUP_DECL(GPIE0, B20, C20);
>
> --
> git-series 0.8.10
