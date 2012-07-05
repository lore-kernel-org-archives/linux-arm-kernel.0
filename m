From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 14:54:05 +0200
Subject: [PATCH] gpio: LPC32xx: Driver cleanup
In-Reply-To: <1339402360-12533-1-git-send-email-stigge@antcom.de>
References: <1339402360-12533-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdYgHnA+EO25UbwBAtjDgyfS2zGGsHhiCtSYpZ0L14yN1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 10:12 AM, Roland Stigge <stigge@antcom.de> wrote:

> Since LPC32xx is now switched over to devicetree based GPIO, the unused
> lpc32xx_gpio_init() can be removed.
>
> Further, the driver title changed since it referred to the wrong file.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Applied.

Thanks,
Linus Walleij
