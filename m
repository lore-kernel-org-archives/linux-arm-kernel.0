From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 23:36:41 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Message-ID: <CACRpkdYE_ysxatAoVwDCf25+-1LLffVnQhbtzwpEWMMAWSnE8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar@ti.com> wrote:

> Adopt pinctrl support to leds-gpio driver based on leds-gpio
> device pointer, pinctrl driver configure SoC pins to GPIO
> mode according to definitions provided in .dts file.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks good from a pinctrl point of view!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
