From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 18 Jan 2018 23:01:59 +1100
Subject: [RFT PATCH] crypto: arm64 - implement SHA-512 using special
 instructions
In-Reply-To: <20180109182302.11521-1-ard.biesheuvel@linaro.org>
References: <20180109182302.11521-1-ard.biesheuvel@linaro.org>
Message-ID: <20180118120159.GB20717@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 06:23:02PM +0000, Ard Biesheuvel wrote:
> Implement the SHA-512 using the new special instructions that have
> been introduced as an optional extension in ARMv8.2.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
