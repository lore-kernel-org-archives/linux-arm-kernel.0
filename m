From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Nov 2013 13:12:40 +0100
Subject: [PATCHv9][ 4/6] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <1383210928-18906-4-git-send-email-denis@eukrea.com>
References: <1383210928-18906-1-git-send-email-denis@eukrea.com>
 <1383210928-18906-4-git-send-email-denis@eukrea.com>
Message-ID: <CACRpkdbKzFFSmC9sE8o+L=HBQ9E-p=Aw7i2e5nNsRHTEt4JFNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:15 AM, Denis Carikli <denis@eukrea.com> wrote:

> This is mostly cut and paste from the imx35 pinctrl driver.
> The data was generated using sed and awk on
>   arch/arm/plat-mxc/include/mach/iomux-mx25.h.
>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - Whitespace cleanup betwen the CC: and Signed-off-by.
> - Kconfig: rebased to make it apply on the new HEAD.

This will be for the next kernel cycle.

I want to see a review from the maintainers first ...
and Markus, can you look at this too?

Yours,
Linus Walleij
