From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 29 Dec 2015 21:35:10 +0800
Subject: [PATCH] crypto: hifn_795x, picoxcell - use ablkcipher_request_cast
In-Reply-To: <9b6f300df7ffd4c5d65253fdbbb2d1a1cba04835.1451310459.git.geliangtang@163.com>
References: <9b6f300df7ffd4c5d65253fdbbb2d1a1cba04835.1451310459.git.geliangtang@163.com>
Message-ID: <20151229133510.GA5307@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2015 at 09:53:07PM +0800, Geliang Tang wrote:
> Use ablkcipher_request_cast() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
