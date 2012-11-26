From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Nov 2012 07:53:41 +0100
Subject: [PATCH] gpio: pl061: remove old comment
In-Reply-To: <9726894cfe3ff11c9f3a95e436ae386637eba98f.1353577495.git.baruch@tkos.co.il>
References: <9726894cfe3ff11c9f3a95e436ae386637eba98f.1353577495.git.baruch@tkos.co.il>
Message-ID: <CACRpkdYW2Y0ExgxMxMU6cpYrN_n3gn55HJ1WvwOWOZ8=v5O+cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 10:46 AM, Baruch Siach <baruch@tkos.co.il> wrote:

> Since 3ab524754 (gpio: pl061: convert to use generic irq chip) we only have one
> spinlock in struct pl061_gpio.
>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
