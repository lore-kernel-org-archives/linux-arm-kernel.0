From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Thu, 26 Mar 2015 12:55:41 +0100
Subject: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
In-Reply-To: <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150326115540.GC16148@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Thu 26 Mar 2015 11:45:52 +0000 or thereabout, Ben Dooks wrote:
> Use <linux/atmel_io.h> to provide IO accessors which work on both
> AVR32 and ARM for on-chip peripherals.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> --
> CC: Nicolas Ferre <nicolas.ferre@atmel.com> (supporter:ATMEL SPI DRIVER)
> CC: Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
> CC: linux-spi at vger.kernel.org (open list:SPI SUBSYSTEM)
> CC: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/spi/spi-atmel.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

<snipp diff>

-- 
BR, HcE
