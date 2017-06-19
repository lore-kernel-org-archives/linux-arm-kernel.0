From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 19 Jun 2017 14:39:44 +0800
Subject: [PATCH] crypto: mediatek - drop .owner field in mtk_crypto_driver
In-Reply-To: <55f4a84740c5d01a35ff6ec68890fcca0b26f28d.1493797414.git.geliangtang@gmail.com>
References: <55f4a84740c5d01a35ff6ec68890fcca0b26f28d.1493797414.git.geliangtang@gmail.com>
Message-ID: <20170619063944.GD13651@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06, 2017 at 11:35:29PM +0800, Geliang Tang wrote:
> Drop .owner field in mtk_crypto_driver, since platform_driver_register()
> will set it automatically.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
