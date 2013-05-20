From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:10:54 +0200
Subject: [PATCH 15/39] crypto: ux500/cryp - Prepare clock before enabling
 it
In-Reply-To: <1368611522-9984-16-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaMMn10nPGXedR5J_AmDEC3a5dff2CoJ5jNcWo6jXe9VQ@mail.gmail.com>
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

Patch applied with Herbert's ACK.

Yours,
Linus Walleij
