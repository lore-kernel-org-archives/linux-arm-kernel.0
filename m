From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 00:52:11 +0200
Subject: [PATCH] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <201208252353.59345.heiko@sntech.de>
References: <201208252353.59345.heiko@sntech.de>
Message-ID: <CACRpkdZws9ifr3WLKGJ-Mz0uYY5=itcd0GmnZYXBOTN7AkU=nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 25, 2012 at 11:53 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Until now the Exynos-SoC was the only Samsung-SoC supporting the GPIOs
> via the device tree. This patch implements dt-support for the
> s3c24xx arches.
>
> The controllers contain only 3 cells, as the underlying gpio controller
> does not support controlling the drive strength on a gpio level.
>
> Tested with the gpio-keys driver on a s3c2416 based machine.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I cannot figure out if you guys have reached consensus on this
patch or not.

I guess this will go through the Samsung tree in any case, I have no
objections from a GPIO subsystem point of view.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
