From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jan 2016 10:09:16 +0100
Subject: [PATCH] mfd: asic3: remove extraneous ')'
In-Reply-To: <5507931.oM3h7nKshR@wuerfel>
References: <5507931.oM3h7nKshR@wuerfel>
Message-ID: <CACRpkdYJW2Z1BCKa0f9b8j0kP2EBrkVEggXyZ8ZZwqpfi-c3gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 10:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> A cleanup patch introduced an extra closing ')' that leads to a
> build error:
>
> drivers/mfd/asic3.c: In function 'asic3_gpio_get':
> drivers/mfd/asic3.c:505:12: error: expected ';' before ')' token
>
> This removes the extra character to get it to build again.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: fd5b4d01a638 ("mfd: asic3: Be sure to clamp return value")
> ---
> This came up today on linux-next. I took the liberty to adjust formatting
> of that line as well, if you prefer the original line wrapping please
> undo that part when applying.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for the mess, apparently one of those I didn't find a good
way of building...

Yours,
Linus Walleij
