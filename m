From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2016 10:28:34 +0200
Subject: [PATCH v2 1/4] gpio: Add AXP209 GPIO driver
In-Reply-To: <20160720141139.25098-2-maxime.ripard@free-electrons.com>
References: <20160720141139.25098-1-maxime.ripard@free-electrons.com>
 <20160720141139.25098-2-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdaHbE1ZZ-f_1xqTwReyLbUZuS+VyLgGSp4hE8CrX3tu=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 4:11 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The AXP209 PMIC has a bunch of GPIOs accessible, that are usually used to
> control LEDs or backlight.
>
> Add a driver for them
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch applied, it's clean and simple. I would suggest the
following immediate improvement (send separate patch):

Add a .get_direction() callback, I have started to push this
for new driver as it gives better userspace experience
and overall better control of stuff.

Yours,
Linus Walleij
