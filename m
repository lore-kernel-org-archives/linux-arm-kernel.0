From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 27 Dec 2016 17:03:55 +0800
Subject: [PATCH] crypto: arm64/aes: reimplement bit-sliced ARM/NEON
 implementation for arm64
In-Reply-To: <1481564758-7275-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1481564758-7275-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161227090355.GD10121@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 05:45:58PM +0000, Ard Biesheuvel wrote:
>
> +	.chunksize		= 8 * AES_BLOCK_SIZE,

Same comment as to the previous patches regarding chunksize.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
