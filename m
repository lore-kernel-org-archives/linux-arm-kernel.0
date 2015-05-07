From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 7 May 2015 11:19:01 +0800
Subject: [PATCH bugfix 1/2] crypto: arm64/sha1-ce - prevent asm code
 finalization in final() path
In-Reply-To: <1430920472-20416-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1430920472-20416-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150507031901.GB29557@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 03:54:31PM +0200, Ard Biesheuvel wrote:
> Ensure that the asm code finalization path is not triggered when
> invoked via final(), since it already takes care of that itself.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Both applied to crypto.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
