From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Jan 2017 12:04:08 +0000
Subject: [RESEND] spi: davinci: Allow device tree devices to use DMA
In-Reply-To: <m24m146jzh.fsf@baylibre.com>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
 <m24m146jzh.fsf@baylibre.com>
Message-ID: <20170113120408.3jtslvgifdpxchvp@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 01:34:10PM -0800, Kevin Hilman wrote:

> I thinks this driver needs an update to use spi_map_buf() to be able to
> handle vmalloc'd buffers before always enabling DMA.

Right.  As I said elsewhere in the thread the driver looks like it needs
some very serious TLC based on a quick scan through.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170113/c376e85e/attachment-0001.sig>
