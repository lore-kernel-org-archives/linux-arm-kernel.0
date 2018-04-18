From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Apr 2018 17:23:15 +0100
Subject: [PATCH][next] spi: pxa2xx: make function pxa2xx_spi_transfer_one
 static
In-Reply-To: <20180418161842.19846-1-colin.king@canonical.com>
References: <20180418161842.19846-1-colin.king@canonical.com>
Message-ID: <20180418162315.GF10061@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 05:18:42PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function pxa2xx_spi_transfer_one is local to the source and
> do not need to be in global scope, so make it static.

Someone already sent a patch for this which I applied earlier today.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/9f9b8c97/attachment-0001.sig>
