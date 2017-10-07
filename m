From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 7 Oct 2017 12:37:38 +0800
Subject: [PATCH] crypto: stm32: use of_device_get_match_data
In-Reply-To: <20170920183140.17018-1-clabbe.montjoie@gmail.com>
References: <20170920183140.17018-1-clabbe.montjoie@gmail.com>
Message-ID: <20171007043738.GI29803@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 08:31:40PM +0200, Corentin Labbe wrote:
> The usage of of_device_get_match_data reduce the code size a bit.
> Furthermore, it prevents an improbable dereference when
> of_match_device() return NULL.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
