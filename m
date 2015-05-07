From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 7 May 2015 11:01:00 +0800
Subject: [PATCH v2 2/7] crypto: add new driver for Marvell CESA
In-Reply-To: <1430742426-21202-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430742426-21202-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150507030100.GA29395@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 02:27:01PM +0200, Boris Brezillon wrote:
> The existing mv_cesa driver supports some features of the CESA IP but is
> quite limited, and reworking it to support new features (like involving the
> TDMA engine to offload the CPU) is almost impossible.
> This driver has been rewritten from scratch to take those new features into
> account.
> 
> This new driver adds support for:
> - new armada SoCs (up to 38x) while keeping support for older ones (Orion
>   and Kirkwood)
> - DMA mode to offload the CPU in case of intensive crypto usage
> - new algorithms: SHA256, DES and 3DES
> 
> The existing CESA driver is kept around to ease transition to this new
> driver (take some time to audit the code and/or wait for users feedback).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

This patch is too big for the mailing list.  Please provide a
URL for people to download and review.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
