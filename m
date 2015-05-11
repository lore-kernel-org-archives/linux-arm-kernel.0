From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 11 May 2015 15:20:25 +0800
Subject: [PATCH 1/2] crypto: arm/sha512 - accelerated SHA-512 using ARM
 generic ASM and NEON
In-Reply-To: <CAKv+Gu9+xrX2nB43cskOoL63WjZGTDdq9ZTO-maWas5u=ng=JQ@mail.gmail.com>
References: <1431074782-22141-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150511065952.GB2598@gondor.apana.org.au>
 <CAKv+Gu9+xrX2nB43cskOoL63WjZGTDdq9ZTO-maWas5u=ng=JQ@mail.gmail.com>
Message-ID: <20150511072025.GA2789@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 09:00:49AM +0200, Ard Biesheuvel wrote:
>
> Yes, you are right. Let me figure out what's going on and send you a
> new version.

Don't worry.  I fixed it up while applying the patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
