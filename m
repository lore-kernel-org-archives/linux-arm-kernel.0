From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 24 Mar 2015 22:27:25 +1100
Subject: [PATCH] crypto/arm: fix big-endian bug in ghash
In-Reply-To: <1427142789-13960-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427142789-13960-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150324112725.GB11405@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 09:33:09PM +0100, Ard Biesheuvel wrote:
> This fixes a bug in the new v8 Crypto Extensions GHASH code
> that only manifests itself in big-endian mode.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
