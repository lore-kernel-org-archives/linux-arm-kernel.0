From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 10 Mar 2014 20:22:00 +0800
Subject: [PATCH] crypto: mxs-dcp: Align the bounce buffers
In-Reply-To: <1393806195-6415-1-git-send-email-marex@denx.de>
References: <1393806195-6415-1-git-send-email-marex@denx.de>
Message-ID: <20140310122200.GF10556@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 01:23:15AM +0100, Marek Vasut wrote:
> The DCP needs the bounce buffers, DMA descriptors and result buffers aligned
> to 64 bytes (yet another hardware limitation). Make sure they are aligned by
> properly aligning the structure which contains them during allocation.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
