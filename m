From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 23 May 2017 13:03:45 +0800
Subject: [PATCH v2 0/9] crypto: add HMAC IPAD/OPAD constant
In-Reply-To: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
References: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
Message-ID: <20170523050345.GF17569@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 08:53:22AM +0200, Corentin Labbe wrote:
> Hello
> 
> Many HMAC users directly use directly 0x36/0x5c values.
> It's better with crypto to use a name instead of directly some crypto constant.
> 
> Changes since v1:
> - Moved constant to include/crypto/hmac.h
> - Added <crypto/hmac.h> to includes
> 
> Corentin Labbe (9):
>   crypto: add hmac IPAD/OPAD constant
>   crypto: brcm - Use IPAD/OPAD constant
>   crypto: ixp4xx - Use IPAD/OPAD constant
>   crypto: marvell - Use IPAD/OPAD constant
>   crypto: mv_cesa - Use IPAD/OPAD constant
>   crypto: omap-sham - Use IPAD/OPAD constant
>   crypto: qat - Use IPAD/OPAD constant
>   crypto: mediatek - Use IPAD/OPAD constant
>   crypto: ccp - Use IPAD/OPAD constant

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
