From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 14:05:25 +0200
Subject: [PATCH V2 1/1] gpio: gpio-vf610: add imx7ulp support
In-Reply-To: <1501596257-20825-1-git-send-email-aisheng.dong@nxp.com>
References: <1501596257-20825-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkda6AmCUyDz-zNQbh9XCCDjUcKqhMH07oET6CEXzXV=0rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 4:04 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> The Rapid General-Purpose Input and Output with 2 Ports (RGPIO2P)
> on MX7ULP is similar to GPIO on Vibrid. But unlike Vibrid, the
> RGPIO2P has an extra Port Data Direction Register (PDDR) used
> to configure the individual port pins for input or output.
>
> We introduce a bool have_paddr with fsl_gpio_soc_data data
> to distinguish this differences. And we support getting the output
> status by checking the GPIO direction in PDDR.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> ---
> ChangeLog:
> v1->v2:
>  * remove flags and use bool have_paddr instead

Patch applied.

Yours,
Linus Walleij
