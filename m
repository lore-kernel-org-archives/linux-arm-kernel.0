From: marex@denx.de (Marek Vasut)
Date: Fri, 26 Oct 2012 14:31:53 +0200
Subject: [PATCH 1/2] spi: mxs: Assign message status after transfer
 finished
In-Reply-To: <20121017071026.GB14199@opensource.wolfsonmicro.com>
References: <1350181976-18233-1-git-send-email-marex@denx.de>
 <20121017071026.GB14199@opensource.wolfsonmicro.com>
Message-ID: <201210261431.54371.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Brown,

> On Sun, Oct 14, 2012 at 04:32:55AM +0200, Marek Vasut wrote:
> > In the current code implementing the MXS SPI driver, every transferred
> > message had assigned status = 0, which is not correct. Properly assign
> > status returned from the I/O functions.
> 
> Applied both, thanks.

Will they hit 3.7 please?

Best regards,
Marek Vasut
