From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 May 2014 11:55:17 +0200
Subject: [PATCH v2 11/11] clk: versatile: add versatile OSC support
In-Reply-To: <1401403221-27523-12-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
 <1401403221-27523-12-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdapYuEVNCq5dQ3R22JChQEqLd5ib=a=VbCvHPffoQHX_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 12:40 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Versatile platforms share the same OSC programming model as Integrator
> platforms. Add the necessary parameters and init functions for Versatile.
>
> Renaming the file to clk-versatile.c as versatile is used as the family
> name for ARM, Ltd. boards.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2:
> - Rename clk-integrator.c to clk-versatile.c

Nice!

> --- a/drivers/clk/versatile/clk-integrator.c
> +++ b/drivers/clk/versatile/clk-versatile.c

I bet you want to augment the comments in the top of the file
header a bit to mention the Versatiles.

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
