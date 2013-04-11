From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 17:48:27 +0100
Subject: [PATCH 19/30] ASoC: samsung: use irq resource for idma
In-Reply-To: <1365638712-1028578-20-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-20-git-send-email-arnd@arndb.de>
Message-ID: <20130411164827.GL9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:05:01AM +0200, Arnd Bergmann wrote:
> With multiplatform kernels, we cannot use hardwired IRQ
> numbers in device drivers. This changes the idma driver
> to use a proper resource, like all other drivers do.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/02c330bd/attachment.sig>
