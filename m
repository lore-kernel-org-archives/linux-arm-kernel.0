From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 10:15:47 +0200
Subject: [PATCH RESEND] gpio: LPC32xx: Driver cleanup
In-Reply-To: <1340050738-22988-1-git-send-email-stigge@antcom.de>
References: <1340050738-22988-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdbCTLrOj5LOsDbVBsOO1W-etCXp_sV+OqG=Tc7UjQQJ9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:18 PM, Roland Stigge <stigge@antcom.de> wrote:

> Since LPC32xx is now switched over to devicetree based GPIO, the unused
> lpc32xx_gpio_init() can be removed.
>
> Further, the driver title changed since it referred to the wrong file.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
