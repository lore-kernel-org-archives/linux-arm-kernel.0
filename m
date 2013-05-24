From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 08:26:04 +0200
Subject: [PATCH 5/6] crypto: ux500/cryp - Enable DT probing of the driver
In-Reply-To: <1368703646-26418-6-git-send-email-lee.jones@linaro.org>
References: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
 <1368703646-26418-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbfCyUNevTWzW5JzPoOY83j2vPgcPNg_hU=SDMp1GX-0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 1:27 PM, Lee Jones <lee.jones@linaro.org> wrote:

> By providing an OF match table with a suitable compatible string, we
> can ensure the ux500-crypt driver is probed by supplying an associated
> DT node in a given platform's Device Tree.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-crypto at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/crypto/ux500/cryp/cryp_core.c |    6 ++++++

W00t! No binding document?

OK I guess it's just reg, irq ... but still it's compulsory,
right?

Yours,
Linus Walleij
