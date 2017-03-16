From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 16 Mar 2017 16:42:49 +0800
Subject: [RFC 0/7] crypto: caam - add Queue Interface (QI) support
In-Reply-To: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
References: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
Message-ID: <20170316084249.GB11653@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 04:52:06PM +0200, Horia Geant? wrote:
> The patchset adds support for CAAM Queue Interface (QI), the additional
> interface (besides job ring) available for submitting jobs to the engine
> on platforms having DPAA (Datapath Acceleration Architecture).
> 
> Patches 1-4 are QMan dependencies.
> I would prefer to take them through the crypto tree,
> but I am open to suggestions.
> 
> Patch 5 adds a missing double inclusion guard in desc_constr.h.
> 
> Patch 6 adds the caam/qi job submission backend.
> 
> Patch 7 adds algorithms (ablkcipher and authenc) that run on top
> of caam/qi. For now, their priority is set lower than caam/jr.

I'm fine with the crypto bits.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
