From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 5 Jun 2013 16:42:11 +0800
Subject: [PATCH] crypto: sahara: fix building as module
In-Reply-To: <3573891.yE7nyLPekp@wuerfel>
References: <3573891.yE7nyLPekp@wuerfel>
Message-ID: <20130605084211.GB12202@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 11:57:37PM +0200, Arnd Bergmann wrote:
> The sahara crypto driver has an incorrect MODULE_DEVICE_TABLE, which
> prevents us from actually building this driver as a loadable module.
> 
> sahara_dt_ids is a of_device_id array, so we have to use
> MODULE_DEVICE_TABLE(of, ...).
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Javier Martin <javier.martin@vista-silicon.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>

Patch applied to crypto.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
