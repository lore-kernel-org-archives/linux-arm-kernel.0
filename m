From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 27 Dec 2016 17:00:01 +0800
Subject: [PATCH v2 2/3] crypto: arm64/chacha20 - implement NEON version
 based on SSE3 code
In-Reply-To: <1481294033-23508-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1481294033-23508-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481294033-23508-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161227090001.GB10121@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 02:33:52PM +0000, Ard Biesheuvel wrote:
>
> +	.chunksize		= 4 * CHACHA20_BLOCK_SIZE,

This should use a new attribute specific to the walk interface.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
