From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 12 Mar 2015 21:19:49 +1100
Subject: [PATCH v2 0/5] ARM: crypto: ARMv8 Crypto Extensions
In-Reply-To: <1425977268-27835-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425977268-27835-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150312101949.GA18614@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 09:47:43AM +0100, Ard Biesheuvel wrote:
> This is v2 of the ARM crypto series I sent out yesterday, erroneously without
> a cover letter.
> 
> Patch #1 moves all the ARM specific crypto options to arch/arm/crypto/Kconfig.
> 
> Patches #2 - #5 implement SHA1, SHA-224/256, AES-ECB/CBC/CTR/XTS and GHASH,
> respectively.
> 
> Changes since v1:
> - fixes for BE (currently still untested)
> - added alignment hints where appropriate (e,g., [rX, :128])
> - various minor tweaks

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
