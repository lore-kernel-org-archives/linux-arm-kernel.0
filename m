From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 4 Sep 2018 17:44:14 +0800
Subject: [PATCH 1/4] lib/crc32: make core crc32() routines weak so they
 can be overridden
In-Reply-To: <20180827110245.14812-2-ard.biesheuvel@linaro.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827110245.14812-2-ard.biesheuvel@linaro.org>
Message-ID: <20180904094414.rmonmj27iv3uhees@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 01:02:42PM +0200, Ard Biesheuvel wrote:
> Allow architectures to drop in accelerated CRC32 routines by making
> the crc32_le/__crc32c_le entry points weak, and exposing non-weak
> aliases for them that may be used by the accelerated versions as
> fallbacks in case the instructions they rely upon are not available.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
