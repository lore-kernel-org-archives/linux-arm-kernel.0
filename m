From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 17:55:36 +0100
Subject: [PATCH 29/30] spi: s3c64xx: move to generic dmaengine API
In-Reply-To: <1365638712-1028578-30-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-30-git-send-email-arnd@arndb.de>
Message-ID: <20130411165536.GO9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:05:11AM +0200, Arnd Bergmann wrote:
> The spi-s3c64xx uses a Samsung proprietary interface for
> talking to the DMA engine, which does not work with
> multiplatform kernels.

This doesn't apply against my spi-next, can you please check and resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/992e6ac6/attachment.sig>
