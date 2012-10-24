From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 09:45:19 +0200
Subject: [PATCH 1/1] pinctrl: at91: fix typo on PULL_UP
In-Reply-To: <1351009680-15892-1-git-send-email-plagnioj@jcrosoft.com>
References: <1351009680-15892-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdbVFnDPu1dfYgTaiz48ioDLJxxSmFXkeQiej157DFZRQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 6:28 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-at91.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index c87c2c5..0757e94 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -58,7 +58,7 @@ static struct at91_gpio_chip *gpio_chips[MAX_GPIO_BANKS];
>
>  static int gpio_banks;
>
> -#define PULL_UP                (0 << 1)
> +#define PULL_UP                (1 << 0)

Makes perfect sense. Shall I just apply this to the at91 branch too?

Yours,
Linus Walleij
