From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 1 Mar 2017 19:52:02 +0800
Subject: [PATCH 1/2] crypto: arm/crc32 - fix build error with outdated
 binutils
In-Reply-To: <1488292617-27317-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1488292617-27317-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170301115202.GA11489@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 02:36:56PM +0000, Ard Biesheuvel wrote:
> Annotate a vmov instruction with an explicit element size of 32 bits.
> This is inferred by recent toolchains, but apparently, older versions
> need some help figuring this out.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
