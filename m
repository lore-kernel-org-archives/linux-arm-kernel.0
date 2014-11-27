From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Nov 2014 14:49:24 +0100
Subject: [PATCH v3 3/3] ARM: meson: select PINCTRL_MESON and
 ARCH_REQUIRE_GPIOLIB
In-Reply-To: <1416168856-12747-4-git-send-email-b.galvani@gmail.com>
References: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
 <1416168856-12747-4-git-send-email-b.galvani@gmail.com>
Message-ID: <CACRpkdYSvOqvttyZw0wgDhXxRGR0KLfRi-N5Ym5W4mzjAV9=Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 9:14 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> Make sure that the Meson pinctrl driver is built whenever Meson
> support is enabled.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

(Given we can merge the pinctrl driver)

Please merge this through the ARM SoC tree.

Yours,
Linus Walleij
