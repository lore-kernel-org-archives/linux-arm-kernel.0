From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Feb 2016 10:53:57 +0100
Subject: [PATCH 2/2] pinctrl: stm32: Fix compile testing selection
In-Reply-To: <1454954259-4923-3-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454954259-4923-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1454954259-4923-3-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdb87qRD9OofJgkLUvMmcQSqXcu6xFsP7X7ztPueSKzPhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2016 at 6:57 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> While selecting the driver for compile testing seemed possible,
> the driver was not compiled because the driver directory was only
> added if ARCH_STM32 was selected.
>
> This patch now makes the pinctrl Makefile to add stm32 directory if
> PINCTRL_STM32 is selected.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Patch applied.

Yours,
Linus Walleij
