From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 10:14:07 +0200
Subject: [PATCH 3/6] pinctrl: uniphier: clean up GPIO port muxing
In-Reply-To: <1501482071-9819-4-git-send-email-yamada.masahiro@socionext.com>
References: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
 <1501482071-9819-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbeuhNRE_-WmGeed0Sj4Zg3r+JnVKX-CET1s3SkD=k4=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 8:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> There are a bunch of GPIO muxing data, but most of them are actually
> unneeded because GPIO-to-pin mapping can be specified by "gpio-ranges"
> DT properties.
>
> Tables that contain a set of GPIO pins are still needed for the named
> mapping by "gpio-ranges-group-names".  This is a much cleaner way for
> UniPhier SoC family where GPIO numbers are not straight mapped to pin
> numbers.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
