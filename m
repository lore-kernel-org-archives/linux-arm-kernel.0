From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Oct 2012 16:10:27 +0900
Subject: [PATCH 1/2] spi: mxs: Assign message status after transfer
 finished
In-Reply-To: <1350181976-18233-1-git-send-email-marex@denx.de>
References: <1350181976-18233-1-git-send-email-marex@denx.de>
Message-ID: <20121017071026.GB14199@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2012 at 04:32:55AM +0200, Marek Vasut wrote:
> In the current code implementing the MXS SPI driver, every transferred
> message had assigned status = 0, which is not correct. Properly assign
> status returned from the I/O functions.

Applied both, thanks.
