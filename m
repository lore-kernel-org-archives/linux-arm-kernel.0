From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 3 Aug 2017 14:09:50 +0800
Subject: [PATCH 1/4] crypto: caam/jr - add support for DPAA2 parts
In-Reply-To: <20170718153050.15330-2-horia.geanta@nxp.com>
References: <20170718153050.15330-1-horia.geanta@nxp.com>
 <20170718153050.15330-2-horia.geanta@nxp.com>
Message-ID: <20170803060950.GA12039@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 06:30:47PM +0300, Horia Geant? wrote:
> Add support for using the caam/jr backend on DPAA2-based SoCs.
> These have some particularities we have to account for:
> -HW S/G format is different
> -Management Complex (MC) firmware initializes / manages (partially)
> the CAAM block: MCFGR, QI enablement in QICTL, RNG
> 
> Signed-off-by: Horia Geant? <horia.geanta@nxp.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
