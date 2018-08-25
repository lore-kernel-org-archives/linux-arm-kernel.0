From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 25 Aug 2018 21:27:29 +0800
Subject: [PATCH] crypto: arm64/sm4-ce - check for the right CPU feature bit
In-Reply-To: <20180807211836.9899-1-ard.biesheuvel@linaro.org>
References: <20180807211836.9899-1-ard.biesheuvel@linaro.org>
Message-ID: <20180825132728.i6rauxjalm6iuh4f@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 11:18:36PM +0200, Ard Biesheuvel wrote:
> ARMv8.2 specifies special instructions for the SM3 cryptographic hash
> and the SM4 symmetric cipher. While it is unlikely that a core would
> implement one and not the other, we should only use SM4 instructions
> if the SM4 CPU feature bit is set, and we currently check the SM3
> feature bit instead. So fix that.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
