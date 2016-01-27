From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 14:20:38 +0100
Subject: [PATCH v4 0/9] Add STM32 pinctrl/GPIO driver
In-Reply-To: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdYGQ1xObWfka2CN9au6YMGhpu4qcTZpu72bzuJjO38tog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 1:16 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> This is the fourth round of STM32 pinctrl series, which takes into
> account comments made by Patrice on patch 4.

I have applied patch 2 and 4 to the pinctrl tree.

Please put the rest of the patches in through ARM SoC, you can
add my
Acked-by: Linus Walleij <linus.walleij@linaro.org>
to them.

AFAICT there is no compile-time dependency between these two
patches and the rest, so it should merge just fine.

Yours,
Linus Walleij
