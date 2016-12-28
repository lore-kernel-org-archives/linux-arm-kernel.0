From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 28 Dec 2016 17:25:13 +0800
Subject: [PATCH v2 1/3] crypto: chacha20 - convert generic and x86
 versions to skcipher
In-Reply-To: <C46A3CDE-2329-4171-B4C5-071423EC3B4B@linaro.org>
References: <1481294033-23508-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481294033-23508-2-git-send-email-ard.biesheuvel@linaro.org>
 <20161227100452.GB10629@gondor.apana.org.au>
 <20161228091801.GA12318@gondor.apana.org.au>
 <C46A3CDE-2329-4171-B4C5-071423EC3B4B@linaro.org>
Message-ID: <20161228092513.GA12546@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 09:23:07AM +0000, Ard Biesheuvel wrote:
>
> Ehm, could you keep this one and revert the other two instead please?  This patch will not change in the respin, and the other two are blkciphers rather than skciphers (and in the arm64 version, I optimized the asm code as well) so they will look rather different ( as they do in the nacked v2)

OK I will keep this patch and revert the other two.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
