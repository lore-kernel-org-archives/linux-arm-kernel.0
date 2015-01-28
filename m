From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 11:20:02 +0100
Subject: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
In-Reply-To: <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CABxcv=mhUFYdHgA7F2dFw85Yd2ucBn6k00soHc-Vg+GWLL_7MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The need for reset GPIOs has several times been pointed out from
> erlier posted patchsets. Especially some WLAN chips which are
> attached to an SDIO interface may use a GPIO reset.
>
> The reset GPIO is asserted at initialization and prior we start the
> power up procedure. The GPIO will be de-asserted right after the power
> has been provided to the card, from the ->post_power_on() callback.
>
> Note, the reset GPIO is optional. Thus we don't return an error even if
> we can't find a GPIO for the consumer.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
