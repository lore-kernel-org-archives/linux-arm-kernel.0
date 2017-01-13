From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 13 Jan 2017 22:37:34 +0800
Subject: [PATCH] crypto: arm/aes - avoid reserved 'tt' mnemonic in asm code
In-Reply-To: <1484296406-13224-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484296406-13224-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170113143734.GC26101@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 08:33:26AM +0000, Ard Biesheuvel wrote:
> The ARMv8-M architecture introduces 'tt' and 'ttt' instructions,
> which means we can no longer use 'tt' as a register alias on recent
> versions of binutils for ARM. So replace the alias with 'ttab'.
> 
> Fixes: 81edb4262975 ("crypto: arm/aes - replace scalar AES cipher")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
