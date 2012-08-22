From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 18:00:25 +0100
Subject: [PATCH 14/14] drivers/spi/spi-s3c24xx.c: fix error return code
In-Reply-To: <alpine.DEB.2.02.1208221342240.1991@hadrien>
References: <1345365870-29831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345365870-29831-15-git-send-email-Julia.Lawall@lip6.fr>
 <1b3201cd8049$e753f720$b5fbe560$%kim@samsung.com>
 <20120822114015.GI7995@opensource.wolfsonmicro.com>
 <alpine.DEB.2.02.1208221342240.1991@hadrien>
Message-ID: <20120822170025.GV7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 01:42:47PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Initialize return variable before exiting on an error path.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/a09091e8/attachment.sig>
