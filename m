From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Apr 2013 19:33:01 +0100
Subject: [PATCH v8 3/8] spi/spi-atmel: add dmaengine support
In-Reply-To: <20130403102332.GA4633@lnx-rg>
References: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
 <1364968759-24036-1-git-send-email-wenyou.yang@atmel.com>
 <20130403102332.GA4633@lnx-rg>
Message-ID: <20130423183301.GX5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 12:23:35PM +0200, Richard GENOUD wrote:

Richard, delete irrelevant context from your mails - it makes it much
easier to find the content you added.

> On [mer., 03.04.2013 13:59:19], Wenyou Yang wrote:

> As I did some work on that one:
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> 
> BUT, there's one thing not working (at least for me !):
> With DMA enabled, using spidev.
> if we use the ioctl SPI_IOC_MESSAGE(x) (tested with x=3):

I'd been expecting an updated series with this rolled in?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/86a7f8bb/attachment.sig>
