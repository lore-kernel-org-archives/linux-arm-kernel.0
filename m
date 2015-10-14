From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Oct 2015 09:39:03 +0200
Subject: [PATCH 2/3] hwrng: stm32 - add support for STM32 HW RNG
In-Reply-To: <1444638090-22886-3-git-send-email-daniel.thompson@linaro.org>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
 <1444638090-22886-1-git-send-email-daniel.thompson@linaro.org>
 <1444638090-22886-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <CACRpkdZgHv+1w2Toj-JBk6WA+1q-wU7BCuZi2b_QWB2kq3K=Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 10:21 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:

> Add support for STMicroelectronics STM32 random number generator.
>
> The config value defaults to N, reflecting the fact that STM32 is a
> very low resource microcontroller platform and unlikely to be targeted
> by any "grown up" defconfigs.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

This is a fine driver, love the performance boost you reported
and stand corrected on the likeness of the other Nomadik driver.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)

Now this read() function is so nice that I feel obliged to
go in and tidy up the Nomadik driver to be as nice.

Yours,
Linus Walleij
