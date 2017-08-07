From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 7 Aug 2017 19:01:31 +0800
Subject: [PATCH] lib/mpi: fix build with clang
In-Reply-To: <a614598d896b9fcdde4e6a209c7e45a4@agner.ch>
References: <20170420034022.24109-1-stefan@agner.ch>
 <a614598d896b9fcdde4e6a209c7e45a4@agner.ch>
Message-ID: <20170807110130.GA21693@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 05, 2017 at 08:31:11PM -0700, Stefan Agner wrote:
> Hi Herbert,
> 
> This still applies fine on 4.13-rc3, any chance to get it merged through
> one of your trees?

If you want it to go through cryptodev you need to post the patches
to linux-crypto at vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
