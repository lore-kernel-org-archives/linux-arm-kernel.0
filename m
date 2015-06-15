From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 Jun 2015 13:26:48 +0200
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <20150615095944.GA32199@gondor.apana.org.au>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150615095944.GA32199@gondor.apana.org.au>
Message-ID: <20150615132648.7ed1a2a6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jun 2015 17:59:44 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Jun 12, 2015 at 09:15:56AM +0200, Boris Brezillon wrote:
> > +struct ahash_alg mv_ahmac_sha1_alg = {
> > +	.init = mv_cesa_ahmac_sha1_init,
> > +	.update = mv_cesa_ahash_update,
> > +	.final = mv_cesa_ahash_final,
> > +	.finup = mv_cesa_ahash_finup,
> > +	.digest = mv_cesa_ahmac_sha1_digest,
> > +	.setkey = mv_cesa_ahmac_sha1_setkey,
> 
> Please add import/export functions for hmac too.

Oh, that's an oversight. I'll fix that too.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
