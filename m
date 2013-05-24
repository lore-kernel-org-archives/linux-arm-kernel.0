From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 24 May 2013 14:21:10 +0800
Subject: [PATCH 5/6] crypto: ux500/cryp - Enable DT probing of the driver
In-Reply-To: <CACRpkdZHT0g_Agtug6jC3rU+DYKOpmwqZ9eQAkRGRw5Kj0wW4A@mail.gmail.com>
References: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
 <1368703646-26418-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZHT0g_Agtug6jC3rU+DYKOpmwqZ9eQAkRGRw5Kj0wW4A@mail.gmail.com>
Message-ID: <20130524062110.GA32684@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 08:20:38AM +0200, Linus Walleij wrote:
> On Thu, May 16, 2013 at 1:27 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > By providing an OF match table with a suitable compatible string, we
> > can ensure the ux500-crypt driver is probed by supplying an associated
> > DT node in a given platform's Device Tree.
> >
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: linux-crypto at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Herbert, can I have your ACK on patch 5 & 6 in this series to take it
> through the ARM SoC tree?

Sure,

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
