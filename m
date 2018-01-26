From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 26 Jan 2018 23:46:41 +0800
Subject: [PATCH] crypto: picoxcell - Fix error handling in spacc_probe()
In-Reply-To: <1516398795-9018-1-git-send-email-khoroshilov@ispras.ru>
References: <1516398795-9018-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <20180126154641.GJ4002@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 20, 2018 at 12:53:15AM +0300, Alexey Khoroshilov wrote:
> If clk_get() fails, device_remove_file() looks inappropriate.
> 
> The error path, where all crypto_register fail, misses resource
> deallocations.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
