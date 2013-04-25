From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 14:03:57 +0200
Subject: [PATCH 8/9] crypto: ux500/[cryp|hash] - Show successful start-up
 in the bootlog
In-Reply-To: <1366280825-31136-9-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYLQtdqCmJ_tt=1DtNeeZVWkL+S6tBG74Li9kOkU25b4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:27 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The Cryp driver is currently silent and the Hash driver prints the
> name of its probe function unnecessarily. Let's just put a nice
> descriptive one-liner there instead.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
