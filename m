From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:15:23 +0200
Subject: [PATCH 18/39] crypto: ux500/[cryp|hash] - Show successful
 start-up in the bootlog
In-Reply-To: <1368611522-9984-19-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-19-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYUAFm4G1R=0u_c8rFH1ke5n67E_POf0wysQKVmX2pD7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The Cryp driver is currently silent and the Hash driver prints the
> name of its probe function unnecessarily. Let's just put a nice
> descriptive one-liner there instead.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied with Herbert's ACK.

Thanks,
Linus Walleij
