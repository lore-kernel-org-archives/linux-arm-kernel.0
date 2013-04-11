From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 17:48:59 +0100
Subject: [PATCH 22/30] ASoC: samsung/idma: export idma_reg_addr_init
In-Reply-To: <1365638712-1028578-23-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-23-git-send-email-arnd@arndb.de>
Message-ID: <20130411164858.GN9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:05:04AM +0200, Arnd Bergmann wrote:
> The idma_reg_addr_init function is used by the samsung i2s driver,
> which can be a loadable module, so we have to export this function.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/470f812c/attachment.sig>
