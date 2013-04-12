From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Apr 2013 13:55:21 +0100
Subject: [PATCH v2] spi: s3c64xx: move to generic dmaengine API
In-Reply-To: <201304112242.03252.arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-30-git-send-email-arnd@arndb.de>
 <20130411165536.GO9243@opensource.wolfsonmicro.com>
 <201304112242.03252.arnd@arndb.de>
Message-ID: <20130412125521.GA12534@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 10:42:03PM +0200, Arnd Bergmann wrote:
> The spi-s3c64xx uses a Samsung proprietary interface for
> talking to the DMA engine, which does not work with
> multiplatform kernels.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130412/88450ddb/attachment.sig>
