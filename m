From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 08:20:38 +0200
Subject: [PATCH 5/6] crypto: ux500/cryp - Enable DT probing of the driver
In-Reply-To: <1368703646-26418-6-git-send-email-lee.jones@linaro.org>
References: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
 <1368703646-26418-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZHT0g_Agtug6jC3rU+DYKOpmwqZ9eQAkRGRw5Kj0wW4A@mail.gmail.com>
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

Herbert, can I have your ACK on patch 5 & 6 in this series to take it
through the ARM SoC tree?

Yours,
Linus Walleij
