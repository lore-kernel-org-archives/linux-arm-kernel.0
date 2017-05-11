From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 16:03:38 +0200
Subject: [PATCH v2 1/4] pinctrl: meson: meson8: add the PWM pins
In-Reply-To: <20170506165751.12442-2-martin.blumenstingl@googlemail.com>
References: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
 <20170506165751.12442-1-martin.blumenstingl@googlemail.com>
 <20170506165751.12442-2-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdYQ0wkG0_e1htvNc=8vrs3sa9AQC7b7jtAXbmSPAhSU-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 6, 2017 at 6:57 PM, Martin Blumenstingl
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

Took out the older patch and applied this instead.

Yours,
Linus Walleij
