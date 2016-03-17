From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 17 Mar 2016 19:13:31 +0800
Subject: [PATCH] crypto: marvell/cesa - forward devm_ioremap_resource()
 error code
In-Reply-To: <1458208031-13463-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458208031-13463-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160317111331.GB5658@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 10:47:10AM +0100, Boris Brezillon wrote:
> Forward devm_ioremap_resource() error code instead of returning
> -ENOMEM.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Fixes: f63601fd616a ("crypto: marvell/cesa - add a new driver for Marvell's CESA")
> Cc: <stable@vger.kernel.org> # 4.2+

All three patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
