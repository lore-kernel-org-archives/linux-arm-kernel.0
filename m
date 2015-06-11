From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 11 Jun 2015 15:34:49 +0800
Subject: [PATCH 2/2] scatterlist: cleanup sg_chain() and sg_unmark_end()
In-Reply-To: <20150611073107.GD1905@lst.de>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162715.21910.77696.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150610053803.GA1693@gondor.apana.org.au>
 <20150611073107.GD1905@lst.de>
Message-ID: <20150611073448.GA15236@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 09:31:07AM +0200, Christoph Hellwig wrote:
>
> It allows getting a cleaner slate for the next merge window, which seems
> useful on it's own.  The re-addition of scatterwalk_sg_next seems next,
> but getting rid of the open-coded sg_chain is useful.

Sure I can take the crypto bits.

> Maybe you can take it through the crypto tree and also kill off the
> scatterwalk_sg_chain name as well while we're at it?

Sure I'm happy to take such a patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
