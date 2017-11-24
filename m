From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 24 Nov 2017 15:55:59 +1100
Subject: [PATCH] crypto: arm64/aes - do not call
 crypto_unregister_skcipher twice on error
In-Reply-To: <CAKv+Gu9m3v_iMdg8ngX-3x1HT+c8D52dhjJ=MiTp11VByD=ewA@mail.gmail.com>
References: <1511338114-39583-1-git-send-email-clabbe@baylibre.com>
 <CAKv+Gu9m3v_iMdg8ngX-3x1HT+c8D52dhjJ=MiTp11VByD=ewA@mail.gmail.com>
Message-ID: <20171124045558.GA14676@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 08:55:14AM +0000, Ard Biesheuvel wrote:
>
> Would this also fix it?

Looks good.  Could you resubmit with a sign-off?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
