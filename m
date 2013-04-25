From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 14:00:00 +0200
Subject: [PATCH 5/9] crypto: ux500/cryp - Fix compile error
In-Reply-To: <1366280825-31136-6-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZNFqbHJB7R5zqVzkAn_nV=G+c27YRB7VCQxiMyFTnPbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:27 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Clearly this driver hasn't been tested, or even enabled in a while.
>
> drivers/crypto/ux500/cryp/cryp_core.c:1771:3:
>         error: request for member ?pm? in something not a structure or union
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

NAK. I already fixed this. It is in v3.9-rc7.

Yours,
Linus Walleij
