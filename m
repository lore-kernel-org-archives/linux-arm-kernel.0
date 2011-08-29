From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2011 10:41:39 +0200
Subject: [PATCH] spi: Fix builderror in spi-pl022.c
In-Reply-To: <1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
References: <E1Qvo1q-0000qv-TQ@rmk-PC.arm.linux.org.uk>
	<1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
Message-ID: <CACRpkdavhLpsfFwHy3jnHO3o9EC+e6=dt1joMGQD_e3O=HTT-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2011 at 9:26 PM, Peter Huewe <peterhuewe@gmx.de> wrote:

> This patch fixes a build error, introduced by commit (67fc8b9f, "PM: add
> runtime PM support to core Primecell driver") which unfortunately was a little
> bit incomplete and did contain a typo (11 instead of 22).
> I'm not sure how this patch could have been tested back then, if it
> doesn't even compile ;)
>
> The build failure was:
> drivers/spi/spi-pl022.c:2292: error: 'adev' undeclared (first use in
> this function)
> drivers/spi/spi-pl022.c:2344: error: 'pl022_suspend' undeclared here
> (not in a function)
>
> The build failure appears e.g. for the u8500 and realview defconfig.
>
> LinuxVersion: linux next-20110826
>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
