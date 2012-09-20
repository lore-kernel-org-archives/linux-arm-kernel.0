From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 08:34:46 +0200
Subject: [PATCH 1/1] ARM: ux500: Fix SSP register address format
In-Reply-To: <1347983548-15243-1-git-send-email-lee.jones@linaro.org>
References: <1347983548-15243-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb3KMMOvyi2kKGXUNH+=8Cy3xNDRa7Ez6aSLgod_8mF9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 5:52 PM, Lee Jones <lee.jones@linaro.org> wrote:

> SSP won't probe unless the specified register address format
> is correct i.e. we have to specify that the address is in hex.
> After this patch has been applied, the SSP (SPI) driver probes
> as expected.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
