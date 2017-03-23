From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 09:46:34 +0100
Subject: [PATCH v2 1/2] pinctrl: meson: gxl: add the missing PWM pin
 definitions
In-Reply-To: <20170318122736.11592-2-martin.blumenstingl@googlemail.com>
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
 <20170318122736.11592-1-martin.blumenstingl@googlemail.com>
 <20170318122736.11592-2-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdYYWut2aJMj1kVxisfcyur5BT9i9zSzYd8FVU9DY6taKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 1:27 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> This adds support for the missing PWM pins on Meson GXL SoCs, namely:
> - PWM_A
> - PWM_B
> - PWM_C
> - PWM_F (GPIOX_7 and GPIOCLK_1 can be selected as output)
> - PWM_AO_A (GPIOAO_3 and GPIOAO_8 can be selected as output)
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied.

Yours,
Linus Walleij
