From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Aug 2011 14:46:49 +0200
Subject: [PATCH 1/3] gpio/nomadik: remove pull-pinconfig and add SPI2
In-Reply-To: <1312913020-7508-1-git-send-email-linus.walleij@stericsson.com>
References: <1312913020-7508-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdbyjj+7Lm9JCLnYLC_z6Tt+XOr9waYjQAezRDyq7Tb=Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 8:03 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Fredrik Svensson <fredrik.xk.svensson@stericsson.com>
>
> Remove PIN_CFG_PULL in pincfg.h for plat-nomadik, PIN_CFG_INPUT
> already takes care of this. Added support for SPI2.
>
> Signed-off-by: Fredrik Svensson <fredrik.xk.svensson@stericsson.com>
> Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Ping on these three patches too ....

Thanks,
Linus Walleij
