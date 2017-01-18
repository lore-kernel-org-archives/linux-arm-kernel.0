From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2017 11:22:45 +0100
Subject: [PATCH 2/2] ARM64: dts: meson-gx: add the missing uart_AO_B
In-Reply-To: <20170115222029.8271-3-martin.blumenstingl@googlemail.com>
References: <20170115222029.8271-1-martin.blumenstingl@googlemail.com>
 <20170115222029.8271-3-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdY9LGHJinCeJvJ=38fpWU7eAZwuv5-HG=kEFKzouAF-vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 15, 2017 at 11:20 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> This adds the missing node for the uart_AO_B port to the meson-gx.dtsi
> (as this is supported by GXBB, GXL and GXM) along with the required
> pinctrl pins. This is required as some boards are using it (the boards
> from the Khadas VIM series for example have it exposed on the pin
> headers).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through the apropriate ARM SoC-feed tree.

Yours,
Linus Walleij
