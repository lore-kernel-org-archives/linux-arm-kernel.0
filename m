From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 15:46:25 +0200
Subject: [PATCH 1/4] pinctrl: meson: meson8b: add the PWM pins
In-Reply-To: <20170504184932.5372-2-martin.blumenstingl@googlemail.com>
References: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
 <20170504184932.5372-2-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdY1xoC3_o66vJwFQF=djLbBDU8LMoU569h0y-rcokOdwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 8:49 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> This adds the missing pins for the PWM controllers found in Amlogic
> Meson8 SoCs. This includes the pins for PWM_A, PWM_B, PWM_C, PWM_D,
> PWM_E and PWM_F controllers.
> There is an additional PWM function with the name PWM_VS in the vendor
> kernel sources which seems to be used for external video input. Thus
> it's not part of this change as the IP block behind the pwm-meson driver
> is not responsible for these pins.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied.

Yours,
Linus Walleij
