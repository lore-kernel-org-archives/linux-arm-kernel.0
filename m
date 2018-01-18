From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 18 Jan 2018 22:41:12 +1100
Subject: [PATCH 0/7] arm64: move literal data into .rodata section
In-Reply-To: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
References: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
Message-ID: <20180118114112.GA20091@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 12:11:35PM +0000, Ard Biesheuvel wrote:
> Prevent inadvertently creating speculative gadgets by moving literal data
> into the .rodata section.
> 
> Patch #1 enables this for C code, by reverting a change that disables the
> GCC feature implementing this. Note that this conflicts with the mitigation
> of erratum #843419 for Cortex-A53.

Ard, which tree is this supposed to go through?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
