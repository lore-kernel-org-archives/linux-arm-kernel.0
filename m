From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 23:11:00 +0200
Subject: [PATCH 28/63] ARM: ux500: Stop passing UART's platform data for
 Device Tree boots
In-Reply-To: <1367591569-32197-29-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-29-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYCABo0AULsiUgwm3g=906iKzp_ZDFKLj=HgDbNK9mNUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It was required to pass DMA channel configuration information to the
> UART driver before the new DMA API was in place. Now that it is, and
> is fully compatible with Device Tree we can stop doing that.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I can't apply this as it is clearly dependent on a patch to
drivers/tty/serial/amba-pl011.c that is not yet upstream.

Yours,
Linus Walleij
