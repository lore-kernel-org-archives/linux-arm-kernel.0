From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 14:15:57 +0100
Subject: [PATCH v9 05/11] gpio: palmas: add in GPIO support for palmas
 charger
In-Reply-To: <1363959373-10671-6-git-send-email-ian@slimlogic.co.uk>
References: <1363959373-10671-1-git-send-email-ian@slimlogic.co.uk>
 <1363959373-10671-6-git-send-email-ian@slimlogic.co.uk>
Message-ID: <CACRpkdbc3U=4T4P-CtbzU1Ds4Fupno__AkZjPRenzdwW0jEOjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 2:36 PM, Ian Lartey <ian@slimlogic.co.uk> wrote:

> Palmas charger has 16 GPIOs
> add palmas_gpio_[read|write|update] api to take account
> second bank of GPIOs
>
> Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> ---
>  drivers/gpio/gpio-palmas.c |   77 ++++++++++++++++++++++++++++++++++++--------
>  include/linux/mfd/palmas.h |   12 ++++++-
>  2 files changed, 74 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
> index e3a4e56..636648c 100644
> --- a/drivers/gpio/gpio-palmas.c
> +++ b/drivers/gpio/gpio-palmas.c
> @@ -1,7 +1,7 @@
>  /*
> - * TI Palma series PMIC's GPIO driver.
> + * TI Palmas series PMIC's GPIO driver.
>   *
> - * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2012-2012, NVIDIA CORPORATION.  All rights reserved.

Do you mean 2012-2013?

Anyway, Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
