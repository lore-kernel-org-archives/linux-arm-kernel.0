From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Apr 2013 19:27:24 +0100
Subject: [PATCH 09/21] spi/sirf: fix MODULE_DEVICE_TABLE
In-Reply-To: <1366734653-488286-10-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-10-git-send-email-arnd@arndb.de>
Message-ID: <20130423182724.GU5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 06:30:41PM +0200, Arnd Bergmann wrote:
> This fixes building the spi-sirf driver as a loadable module, which uses
> an incorrect MODULE_DEVICE_TABLE, by changing the reference to the
> correct symbol.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/372e6fbb/attachment.sig>
