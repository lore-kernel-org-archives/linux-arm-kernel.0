From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 22 Sep 2017 18:14:05 +0800
Subject: [PATCH 00/11] crypto: gcm - add GCM IV size constant
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
Message-ID: <20170922101405.GI16270@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 10:08:07AM +0200, Corentin Labbe wrote:
> Many GCM users use directly GCM IV size instead of using some constant.
> 
> This patch add all IV size constant used by GCM and convert drivers for using them..
> 
> Corentin Labbe (11):
>   crypto: gcm - add GCM iv size constant
>   crypto: caam - Use GCM IV size constant
>   crypto: ccp - Use GCM IV size constant
>   crypto: nx - Use GCM IV size constant
>   crypto: atmel - Use GCM IV size constant
>   crypto: bcm - Use GCM IV size constant
>   crypto: mediatek - Use GCM IV size constant
>   crypto: chelsio - Use GCM IV size constant
>   crypto: omap - Use GCM IV size constant
>   crypto: gcm - Use GCM IV size constant
>   crypto: aesni - Use GCM IV size constant

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
