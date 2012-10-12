From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Oct 2012 22:55:52 +0200
Subject: [PATCH v4] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <1349798756-24777-1-git-send-email-shc_work@mail.ru>
References: <1349798756-24777-1-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdb7V0ROEQZ3v98wCx3UrD00-___qnRaQ89LLFp_YDKt5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 6:05 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

> The CLPS711X CPUs provide some GPIOs for use in the system. This
> driver provides support for these via gpiolib. Due to platform
> limitations, driver does not support interrupts, only inputs and
> outputs.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Hey looking good:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Will you send this through the ARM SoC tree with other
CLPS711x changes, or should I take it into my GPIO tree?

Yours,
Linus Walleij
