From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 19 Jun 2015 14:42:56 +0800
Subject: [PATCH v7 04/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <1434635190-27733-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434635190-27733-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150619064256.GA10246@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 03:46:20PM +0200, Boris Brezillon wrote:
>
> +	dram = mv_mbus_dram_info_nooverlap();

This doesn't compile because it hasn't made it into mainline yet.
I'm afraid this patch-set will have to wait until that happens.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
