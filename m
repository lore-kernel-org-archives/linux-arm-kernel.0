From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Oct 2016 09:26:02 +0100
Subject: [PATCH 0/6] mfd: audit and demodule drivers/mfd/ab* drivers
In-Reply-To: <20161030012440.10495-1-paul.gortmaker@windriver.com>
References: <20161030012440.10495-1-paul.gortmaker@windriver.com>
Message-ID: <CACRpkdafpokbaY13cDj4zoC-OO-zApswCNmrjwzT3QxbPn_fAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 2:24 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> Nothing new here ; just another instance where we had modular remove
> and exit functions -- but the Makefile/Kconfig limited the use case to
> being always built-in; hence the code is useless and needs removing.
>
> So we remove the dead code and the misleading hints of modularity from
> these drivers, hoping that we manage to prevent some new drivers from
> copying these same old mistakes into pending new drivers.
(...)
> Paul Gortmaker (6):
>   mfd: ab3100-core: Make it explicitly non-modular
>   mfd: ab8500-core: Make it explicitly non-modular
>   mfd: ab8500-debugfs: Make it explicitly non-modular
>   mfd: ab8500-gpadc: Make it explicitly non-modular
>   mfd: ab8500: make sysctrl explicitly non-modular
>   mfd: abx500-core: drop unused MODULE_ tags from non-modular code

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For the whole series.

Yours,
Linus Walleij
