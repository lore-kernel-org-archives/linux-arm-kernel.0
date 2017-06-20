From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 20 Jun 2017 11:40:10 +0800
Subject: [PATCH v2 0/3] add support of hardware random generator on
 MediaTek MT7622
In-Reply-To: <cover.1497280813.git.sean.wang@mediatek.com>
References: <cover.1497280813.git.sean.wang@mediatek.com>
Message-ID: <20170620034009.GD17764@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 11:56:53PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Changes since v1:
> - update the bindings with the specific "mediatek,mt7622-rng"
>   instead of the generic one as "mediatek,generic-rng"
> 
> The series add support of hardware RNG on MediaTek MT7622 and
> , runtime PM support and add me as the maintainer for the existing
> and following chipset.
> 
> Sean Wang (3):
>   dt-bindings: rng: add MediaTek MT7622 Hardware Random Generator
>     bindings
>   hwrng: mtk - add runtime PM support
>   MAINTAINERS: add entry for MediaTek Random Number Generator

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
