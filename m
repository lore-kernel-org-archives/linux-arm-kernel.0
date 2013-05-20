From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:05:11 +0200
Subject: [PATCH 12/39] crypto: ux500/hash - Prepare clock before enabling
 it
In-Reply-To: <1368611522-9984-13-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbER9p+RkNauKtpby5Mr=Tu20F-Hd_0jMfpGJYPTEOwvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> If we fail to prepare the ux500-hash clock before enabling it the
> platform will fail to boot. Here we insure this happens.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my dma40 branch with Herbert's ACK.

Yours,
Linus Walleij
