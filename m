From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 19:11:46 +0200
Subject: [PATCH 15/39] crypto: ux500/cryp - Prepare clock before enabling
 it
In-Reply-To: <1368611522-9984-16-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY_9=OO_E9pFLuihVmE4YvLmydk_b+jsGr_R0sELt0UvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> If we fail to prepare the ux500-cryp clock before enabling it the
> platform will fail to boot. Here we insure this happens.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This patch also looks like -rc series stuff for the crypto tree.

BTW: these two clk_prepare_enable() patches are
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
