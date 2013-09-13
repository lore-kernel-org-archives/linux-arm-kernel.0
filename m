From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 09:14:06 +0200
Subject: [PATCH 5/7] staging: media/lirc: switch to use gpiolib
In-Reply-To: <1378816283-8164-1-git-send-email-linus.walleij@linaro.org>
References: <1378816283-8164-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdaBeYTchtQn6-QThAv2XWAT=vd=YarHA1TgVZeLoLNfpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Tue, Sep 10, 2013 at 2:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The lirc serial module has special hooks to work with NSLU2,
> switch these over to use gpiolib, as that is available on the
> ixp4 platform.
>
> Not even compile tested as there is no way to select this
> driver from menuconfig on the ixp4 platform.
>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Greg: I'm seeking an ACK on this patch to take it through
> the GPIO tree as part of a clean-up attempt to remove custom
> GPIO APIs.

Could you ACK this patch if it looks OK to you?

Yours,
Linus Walleij
