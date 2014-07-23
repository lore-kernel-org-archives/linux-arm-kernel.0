From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 23 Jul 2014 21:54:12 +0800
Subject: [PATCH v4 3/3] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20140723134857.GO20328@lukather>
References: <1405169953-13695-1-git-send-email-clabbe.montjoie@gmail.com>
 <1405169953-13695-4-git-send-email-clabbe.montjoie@gmail.com>
 <20140723131620.GC29178@gondor.apana.org.au>
 <20140723134857.GO20328@lukather>
Message-ID: <20140723135412.GA30046@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 03:48:57PM +0200, Maxime Ripard wrote:
>
> The exact opposite has been asked for during v1's review...

Indeed but unfortunately it was bogus advice.  The async interface
brings with it a lot of complexity which should be avoided unless
you actually need it.

Even if you use the sync interface your driver will still be
available to all async users.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
