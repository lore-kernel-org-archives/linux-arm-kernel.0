From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jun 2012 10:50:40 +0200
Subject: [CFT 07/11] spi: omap2-mcspi: add DMA engine support
In-Reply-To: <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdaoOzUD4BV3Hh=ZAOr6ZSE_04NwfJXFoKnadSbmz43JFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 1:08 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP SPI driver. ?This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be independently switched at build time between using DMA
> engine and the private DMA API for the transmit and receive sides.
>
> Tested-by: Shubhrajyoti <shubhrajyoti@ti.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This looks very good,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
