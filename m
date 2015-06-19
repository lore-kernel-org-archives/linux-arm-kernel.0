From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 19 Jun 2015 22:24:44 +0800
Subject: [PATCH v7 00/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150619142444.GA15234@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 03:46:16PM +0200, Boris Brezillon wrote:
> Hello,
> 
> This patch series adds a new driver supporting Marvell's CESA IP.
> This driver addresses some limitations of the existing one.
> >From a performance and CPU load point of view the most important
> limitation in the existing driver is the lack of DMA support, thus
> preventing us from chaining crypto operations.

All applied to cryptodev.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
