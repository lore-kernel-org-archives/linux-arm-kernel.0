From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 05:58:41 -0700
Subject: [PATCH 14/19] ARM: ux500: Apply tc3589x's GPIO/IRQ properties to
 HREF's DT
In-Reply-To: <1347016499-29354-15-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdareUHDsM9Dhh6oFFQ0xgk1n+R--zbGB8wDzWfqUQU8Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch ensures the tc3589x and tc3598x-gpio devices are
> rightfully given interrupt controller status. We also describe
> the tc3598x-gpio GPIO expander in full and specify it as a GPIO
> controller. Finally we reference that the external MMC slot's
> Card Detection GPIO on the HREF is located on the tc3598x-gpio
> expander.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This should come after the enablement patches instead of
before them, right? (Or be merged into them even as
we've discussed.)

Apart from that it looks good,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
