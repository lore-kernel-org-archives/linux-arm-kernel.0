From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 19:07:58 +0200
Subject: [PATCH 12/39] crypto: ux500/hash - Prepare clock before enabling
 it
In-Reply-To: <1368611522-9984-13-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYdf1j+V516CigFeGKv1B+Mf4mZk8g3ZwYAwa=rDP=7vg@mail.gmail.com>
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

This patch seems to be totally independent of the other stuff
in the patch series, and it even seems like an -rc fix to me
(I don't think the crypto device works without this).

This should go into the crypto tree?

Else please convince Herbert to give his ACK on this
before I apply it.

Yours,
Linus Walleij
